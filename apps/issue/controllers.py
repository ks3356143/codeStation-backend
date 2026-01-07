from pathlib import Path
from typing import Literal

from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from django.db.models import Q
from ninja import File, Query, UploadedFile
from ninja_extra import (
    ControllerBase,
    ModelConfig,
    ModelControllerBase,
    ModelEndpointFactory,
    ModelPagination,
    ModelSchemaConfig,
    api_controller,
    paginate,
    route,
)
from ninja_extra.ordering import ordering

# 导入过滤Schema
from apps.issue.filterSchemas import BookFilterSchema, IssueFilterSchema, QuizFilterSchema, \
    CommentFilterSchema
from apps.issue.models import Book, Comment, Issue, IssueType, Quiz
from apps.issue.schema import BookUpdateInputSchema, QuizModelOutSchema

# schema和service导入
from apps.issue.schema import (
    BookOutSchema,
    CommentOutSchema,
    IssueCreateSchema,
    IssueListOutSchema,
    IssueRetrieveOutSchema,
    QuizOnlyTitleSchema,
)
from apps.issue.service import BookModelService, CommentModelService, IssueModelService, QuizModelService
from utils.chen_response import ChenResponse

# 导入自己的分页
from utils.pagination import MyPageNumberPaginationExtra, MyPaginatedResponseSchema

# ~~~~问答模型~~~~
@api_controller('/issue', tags=['问答'])
class IssueModelController(ModelControllerBase):
    @route.get(
        "/getIssuesByContent/",
        response=MyPaginatedResponseSchema[IssueListOutSchema],
        url_name='get_issue_by_content',
        tags=['问答接口'],
        summary='搜索内容查询问答'
    )
    @paginate(MyPageNumberPaginationExtra, page_size=10)
    def get_issue_by_content(self, filters: IssueFilterSchema = Query(...)):
        """模糊查询issue"""
        searchValue = filters.searchValue
        q = Q(issueTitle__icontains=searchValue) | Q(issueContent__icontains=searchValue)
        issues = Issue.objects.filter(q)
        return issues

    @route.get("/change_status/", url_name='change-status', summary='仅切换是否审核通过')
    def change_status(self, status: bool, id: str):
        # 切换问题status
        issue_obj = self.get_object_or_exception(Issue, id=id)
        issue_obj.status = status
        issue_obj.save()
        return ChenResponse(code=200, status=200, message=f'切换成功，当前状态为'
                                                          f'{"开启" if issue_obj.status == True else "未开启"}')

    # 接口工程：条件查询所有Issue(注意屏蔽自动接口)
    list_issues = ModelEndpointFactory.list(
        path="/?enabled=str&type=str&issueTitle=str",
        schema_out=IssueListOutSchema,
        queryset_getter=lambda self, **kw: self.service.get_all(**kw),
        pagination_class=MyPageNumberPaginationExtra,
        pagination_response_schema=MyPaginatedResponseSchema,
        max_page_size=100,
        page_size=10,
        tags=['问答接口'],
        summary="分页查询Issues",
        url_name='issue-list'
    )

    # 自定义操作服务
    service_type = IssueModelService
    model_config = ModelConfig(
        model=Issue,
        # 定义新增/修改Schema(新增user_id和type_id)
        create_schema=IssueCreateSchema,
        # 定义检索Schema
        retrieve_schema=IssueRetrieveOutSchema,
        allowed_routes=["create", "find_one", "update", "patch", "delete"],
        schema_config=ModelSchemaConfig(
            read_only_fields=["id", "create_date", "update_date", "commentNumber", "scanNumber"],
            exclude=set(),
        ),
        # 下面定义openAPI信息
        create_route_info={
            "summary": "新增Issue",
            "description": "新增Issue，需提供user_id和type_id",
            "tags": ["问答接口"],
            "deprecated": False,
        },
    )

# ~~~~问答类型模型~~~~
@api_controller('/type', tags=['类型'])
class TypeModelController(ModelControllerBase):
    model_config = ModelConfig(
        model=IssueType,
        allowed_routes=["list", 'find_one', 'create', 'delete'],
        schema_config=ModelSchemaConfig(
            read_only_fields=["id"],
            exclude=set(),
        ),
        pagination=None,
        list_route_info={
            "summary": "查询问答类型",
            "description": "查询全部问答类型",
            "tags": ["问答类型接口"],
            "deprecated": False,
        },
    )

# ~~~~评论模型~~~~
@api_controller('/comment', tags=['评论'])
class CommentModelController(ModelControllerBase):
    @route.get('/book/', response=MyPaginatedResponseSchema[CommentOutSchema], tags=['评论接口'])
    @paginate(MyPageNumberPaginationExtra, page_size=5, max_page_size=10)
    def get_book_comments(self, book_id: str):
        """分页查询书籍评论"""
        query_set = self.service.get_all(book_id=book_id)
        return query_set

    @route.get("/book_list/", response=MyPaginatedResponseSchema[CommentOutSchema], tags=['评论接口'],
               summary='分页检索评论')
    @paginate(MyPageNumberPaginationExtra, page_size=10)
    def get_all_comments(self, filters: CommentFilterSchema = Query(...)):
        """检索评论接口"""
        qs = Comment.objects.all().order_by("-create_date")
        qs = filters.filter(qs)
        return qs

    list_comments = ModelEndpointFactory.list(
        path="/?issue_id=str",
        queryset_getter=lambda self, **kw: self.service.get_all(**kw),
        pagination_class=MyPageNumberPaginationExtra,
        pagination_response_schema=MyPaginatedResponseSchema,
        schema_out=CommentOutSchema,
        max_page_size=20,
        page_size=5,
        tags=['评论接口'],
        summary="分页查询问答评论",
        url_name='issue-list'
    )

    service_type = CommentModelService
    model_config = ModelConfig(
        model=Comment,
        allowed_routes=["create", "delete"],
        pagination=None,
        schema_config=ModelSchemaConfig(
            read_only_fields=["id", 'create_date', 'update_date'],
            exclude=set(),
        ),
    )

# ~~~~题目模型~~~~
@api_controller('/quiz', tags=['考试题'])
class QuizModelController(ModelControllerBase):
    # 只获取quiz的分类和标题
    @route.get('/getByType/', url_name='quiz_by_type', response=list[QuizOnlyTitleSchema])
    def get_by_type(self):
        # 先查询所有type - 使用prefetch查询减少查询量
        types = IssueType.objects.prefetch_related('quiz_set').all()  # type: ignore
        # 组合返回对象
        res_list = [{
            "type": type_obj,
            'titles': [{
                "id": quiz.id,
                'quizTitle': quiz.quizTitle
            } for quiz in type_obj.quiz_set.only('id', 'quizTitle')]
        } for type_obj in types]
        return res_list

    # 再写一个list_quiz
    @route.get("/get_all_quiz/",
               url_name='get_all_quiz_search',
               response=MyPaginatedResponseSchema[QuizModelOutSchema],
               tags=['考试题'],
               summary='搜索考试题')
    @paginate(MyPageNumberPaginationExtra, page_size=10)
    def get_all_quiz(self, filters: QuizFilterSchema = Query(...)):
        qs = Quiz.objects.all()
        q = Q(quizTitle__icontains=filters.quizTitle)
        if filters.type != 'all':
            q = q & Q(type_id=filters.type)
        return qs.filter(q).order_by('-create_date')

    service_type = QuizModelService
    model_config = ModelConfig(
        model=Quiz,
        allowed_routes=['create', 'list', 'find_one', 'delete', 'update'],
        pagination=ModelPagination(
            klass=MyPageNumberPaginationExtra,
            pagination_schema=MyPaginatedResponseSchema,
            paginator_kwargs={"page_size": 10}
        ),
        schema_config=ModelSchemaConfig(
            read_only_fields=['id', 'create_date', 'update_date'],
            exclude=set(),
            depth=0,
        )
    )

# ~~~~书籍接口~~~~
@api_controller('/book', tags=['书籍'])
class BookModelController(ModelControllerBase):
    @route.get(
        "/getBooksByContent/",
        response=MyPaginatedResponseSchema[BookOutSchema],
        url_name='get_book_by_content',
        tags=['书籍接口'],
        summary='搜索内容查询问答'
    )
    @paginate(MyPageNumberPaginationExtra, page_size=10)
    def get_book_by_content(self, filters: BookFilterSchema = Query(...)):
        """模糊查询book"""
        q = Q(title__icontains=filters.searchValue) | Q(bookInfo__icontains=filters.searchOption)
        # 过滤type
        if filters.type != 'all':
            q = q & Q(type_id=filters.type)
        books = Book.objects.filter(q).order_by('-create_date')
        return books

    @route.put("/update_book/{str:id}", url_name='book-update', tags=['书籍接口'], summary='书籍更新')
    def update_book(self, id: str, data: BookUpdateInputSchema):
        """更新书籍"""
        book_obj = self.get_object_or_exception(Book, error_message="未找到响应书籍，修改失败", id=id)
        update_data = data.dict(exclude_unset=True)
        for field, value in update_data.items():
            setattr(book_obj, field, value)
        book_obj.save(update_fields=list(update_data.keys()))
        return ChenResponse(code=200, status=200, message='成功修改')

    list_books = ModelEndpointFactory.list(
        path="/?type=str",
        schema_out=BookOutSchema,
        queryset_getter=lambda self, **kw: self.service.get_all(**kw),
        pagination_class=MyPageNumberPaginationExtra,
        pagination_response_schema=MyPaginatedResponseSchema,
        max_page_size=100,
        page_size=10,
        tags=['书籍'],
        summary="分页查询书籍并带有type参数",
        url_name='book-list'
    )
    # 自定义操作服务
    service_type = BookModelService
    model_config = ModelConfig(
        model=Book,
        allowed_routes=['create', 'find_one', 'delete'],
        schema_config=ModelSchemaConfig(
            read_only_fields=['id', 'commentNumber', 'scanNumber'],
            exclude=set(),
            # depth=1,
        ),
        # 替换默认retrieve_schema -> list、find_one
        retrieve_schema=BookOutSchema
    )

# ~~~~其他接口~~~~
@api_controller('/common', tags=['通用'])
class ComminController(ControllerBase):
    # ~~~~~~~头像/书籍封面统一上传接口~~~~~~~~
    @route.post("/avatar", summary='上传头像统一接口',
                description='上传头像统一接口返回media路径')
    def update_avatar(self, file_type: Literal['book', 'user'], file: File[UploadedFile]):
        # 首先构建储存路径
        avatar_subdir = Path('user_avatar')
        book_subdir = Path('book_imgs')
        # 防止文件名重复
        from uuid import uuid4
        file_extension = Path(file.name).suffix
        safe_filename = f"{uuid4().hex}{file_extension}"
        # 构建完整路径
        storage_path = avatar_subdir / safe_filename if file_type == 'user' else book_subdir / safe_filename
        saved_path = default_storage.save(storage_path.__str__(), ContentFile(file.read()))
        # 获取文件的访问 URL
        file_url = default_storage.url(saved_path)
        return ChenResponse(code=200, data=file_url)
