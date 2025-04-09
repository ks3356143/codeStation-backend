import traceback
import typing as t
from django.db.models import QuerySet
from ninja_extra import ModelService
from pydantic import BaseModel as PydanticModel

from apps.issue.models import Issue2Type, IssueType
# 导入Schema以便类型提示
from apps.issue.schema import IssueCreateSchema

# ~~~~1.问答模型服务~~~~
class IssueModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        issues = self.model.objects.all()
        # status字段筛选
        enabled = kwargs.get('enabled')
        status = True
        if enabled:
            if enabled.lower() in ('false', '0', 'undefined', 'null'):
                status = False
        return issues.filter(status=status).order_by('-create_date')

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

    # type_id输出

# ~~~~1.评论模型服务~~~~
class CommentModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        issue_id = kwargs.get('issue_id', None)
        return self.model.objects.filter(issue_id=issue_id).order_by('-create_date')

    def create(self, schema: PydanticModel, **kwargs: t.Any) -> t.Any:
        data = schema.model_dump(by_alias=True, exclude={'type', 'commentType'})
        data.update(kwargs)
        try:
            data['commentType'] = 1  # !!!!!!!!!!注意为了解决问题写死，后续写书籍记得改回来
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
