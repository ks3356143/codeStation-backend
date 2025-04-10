from django.db.models import Q
from apps.issue.models import Issue, IssueType, Comment
from ninja import Query
from ninja_extra import (
    route,
    api_controller,
    ModelControllerBase,
    ModelEndpointFactory,
    ModelConfig,
    ModelSchemaConfig,
    paginate
)
# schema和service导入
from apps.issue.schema import IssueListOutSchema, IssueCreateSchema, CommentOutSchema, IssueRetrieveOutSchema
from apps.issue.service import IssueModelService, CommentModelService
# 导入自己的分页
from utils.pagination import MyPageNumberPaginationExtra, MyPaginatedResponseSchema
# 导入过滤Schema
from apps.issue.filterSchemas import IssueFilterSchema

# ~~~~问答模型~~~~
@api_controller('/issue')
class IssueModelController(ModelControllerBase):
    @route.get("/getIssuesByContent/", response=MyPaginatedResponseSchema[IssueListOutSchema],
               url_name='get_issue_by_content',
               tags=['问答接口'], summary='搜索内容查询问答')
    @paginate(MyPageNumberPaginationExtra, page_size=10)
    def get_issue_by_content(self, filters: IssueFilterSchema = Query(...)):
        searchValue = filters.searchValue
        q = Q(issueTitle__icontains=searchValue) | Q(issueContent__icontains=searchValue)
        issues = Issue.objects.filter(q)
        return issues

    # 接口工程：条件查询所有Issue(注意屏蔽自动接口)
    list_issues = ModelEndpointFactory.list(
        path="/?enabled=str&type=str",
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
@api_controller('/type')
class TypeModelController(ModelControllerBase):
    model_config = ModelConfig(
        model=IssueType,
        allowed_routes=["list", 'find_one'],
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
@api_controller('/comment')
class CommentModelController(ModelControllerBase):
    list_comments = ModelEndpointFactory.list(
        path="/?issue_id=str",
        queryset_getter=lambda self, **kw: self.service.get_all(**kw),
        pagination_class=MyPageNumberPaginationExtra,
        pagination_response_schema=MyPaginatedResponseSchema,
        schema_out=CommentOutSchema,
        max_page_size=20,
        page_size=5,
        tags=['评论接口'],
        summary="分页查询评论",
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
