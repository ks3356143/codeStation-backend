import traceback
import typing as t
from django.db.models import QuerySet
from ninja_extra import ModelService
from pydantic import BaseModel as PydanticModel
from apps.issue.models import Issue2Type, IssueType, Issue, Book
# 导入Schema以便类型提示
from apps.issue.schema import IssueCreateSchema
from utils.chen_response import ChenResponse

# ~~~~1.问答模型服务~~~~
class IssueModelService(ModelService):
    def get_all(self, issueTitle: t.Optional[str] = "", **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        # 首先对issueTitle模糊查询
        issues = self.model.objects.filter(issueTitle__icontains=issueTitle).order_by('-create_date')
        # 1.status字段筛选
        enabled = kwargs.get('enabled')
        status = True
        if enabled:
            if enabled.lower() in ('false', '0', 'undefined', 'null'):
                status = False
        # 2.type的筛选
        if enabled != 'all':
            issues = issues.filter(status=status)
        type_id = kwargs.get('type')
        if type_id == 'all':
            return issues
        type_obj = IssueType.objects.filter(id=type_id).first()
        if not type_obj:
            return []
        issue_ids = type_obj.issue2type_set.order_by('-iid__create_date').values_list('iid', flat=True)
        return Issue.objects.filter(id__in=issue_ids).order_by('-create_date')

    # 修改新增方法，多对多字段修改
    def create(self, schema: IssueCreateSchema, **kwargs: t.Any) -> t.Any:
        data = schema.model_dump(by_alias=True, exclude={'type_id'})
        data.update(kwargs)
        try:
            instance = self.model._default_manager.create(**data)
            # 添加和type的关系
            Issue2Type.objects.create(iid=instance, tid_id=schema.type_id)
            return instance
        except TypeError as tex:  # pragma: no cover
            tb = traceback.format_exc()
            msg = (
                    "`%s.%s.create()`得到`TypeError`异常"
                    "这可能是因为序列化程序类上的可写字段不是的有效参数`%s.%s.create()`"
                    "你需要将此字段设置为只读，或覆盖%s.create()方法"
                    "this correctly.\nOriginal exception was:\n %s"
                    % (
                        self.model.__name__,
                        self.model._default_manager.name,
                        self.model.__name__,
                        self.model._default_manager.name,
                        self.__class__.__name__,
                        tb,
                    )
            )
            raise TypeError(msg) from tex

    # scanNumber + 1
    def get_one(self, pk: t.Any, **kwargs: t.Any) -> t.Any:
        obj = super().get_one(pk, **kwargs)
        obj.scanNumber += 1
        obj.save()
        return obj

# ~~~~2.评论模型服务~~~~
class CommentModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Any:
        issue_id = kwargs.get('issue_id', None)
        book_id = kwargs.get('book_id', None)
        if issue_id:
            return self.model.objects.filter(issue_id=issue_id).order_by('-create_date')
        if book_id:
            return self.model.objects.filter(book_id=book_id).order_by('-create_date')
        return self.model.objects.all().order_by("-create_date")

    def create(self, schema: PydanticModel, **kwargs: t.Any) -> t.Any:
        print('进入此处：', schema, kwargs)
        data = schema.model_dump(by_alias=True, exclude={'type', 'commentType'})
        data.update(kwargs)
        try:
            data['commentType'] = schema.commentType.value
            instance = self.model._default_manager.create(**data)
            # 查询出type的obj
            type_obj_list = []
            for type_id in schema.type:
                type_obj_list.append(IssueType.objects.get(id=type_id))
            instance.type.set(type_obj_list)
            return instance
        except TypeError as tex:  # pragma: no cover
            tb = traceback.format_exc()
            msg = (
                    "`%s.%s.create()`得到`TypeError`异常"
                    "这可能是因为序列化程序类上的可写字段不是的有效参数`%s.%s.create()`"
                    "你需要将此字段设置为只读，或覆盖%s.create()方法"
                    "this correctly.\nOriginal exception was:\n %s"
                    % (
                        self.model.__name__,
                        self.model._default_manager.name,
                        self.model.__name__,
                        self.model._default_manager.name,
                        self.__class__.__name__,
                        tb,
                    )
            )
            raise TypeError(msg) from tex

# ~~~~3.书籍模型服务~~~~
class BookModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        books = self.model.objects.all().order_by('-create_date')
        type_id = kwargs.get('type')
        if type_id == 'all':
            return books
        type_obj = IssueType.objects.filter(id=type_id).first()
        if not type_obj:
            return []
        boos_ids = type_obj.issue2type_set.order_by('-iid__create_date').values_list('iid', flat=True)
        return Book.objects.filter(id__in=boos_ids).order_by('-create_date')

    def get_one(self, pk: t.Any, **kwargs: t.Any) -> t.Any:
        obj = super().get_one(pk, **kwargs)
        # 查询时候scanNumber + 1
        obj.scanNumber += 1
        obj.save()
        return obj

# ~~~~4.考试题服务~~~~
class QuizModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        qs = super().get_all(**kwargs)
        return qs

    def update(self, schema: PydanticModel, **kwargs: t.Any) -> t.Any:
        quiz_obj = kwargs.pop('instance', None)
        if quiz_obj:
            update_dict = schema.model_dump(exclude_none=True)
            type_id = update_dict.pop('type', None)
            quiz_obj.type_id = type_id
            for key, value in update_dict.items():
                if hasattr(quiz_obj, key):
                    setattr(quiz_obj, key, value)
            quiz_obj.save()
            return ChenResponse(status=200, message='修改成功')
        return ChenResponse(status=200, message='未找到响应书籍')
