from django.db.models import QuerySet
from typing import Union, List, Any
from ninja_extra import (ModelConfig,
                         ModelControllerBase,
                         ModelSchemaConfig,
                         ModelPagination,
                         api_controller,
                         ModelService)
from ninja import ModelSchema
from apps.issue.models import Issue, IssueType
from apps.user.models import User

# ~~~~问答模型~~~~
class NestUserOutSchema(ModelSchema):
    class Meta:
        model = User
        fields = ['id', 'username', 'name']

class NestTypeOutSchema(ModelSchema):
    class Meta:
        model = IssueType
        fields = "__all__"

class IssueRetrieveSchema(ModelSchema):
    user: NestUserOutSchema
    type: NestTypeOutSchema

    class Meta:
        model = Issue
        exclude = ['user', 'type']

class IssueService(ModelService):
    def get_all(self, **kwargs: Any) -> Union[QuerySet, List[Any]]:
        # 条件筛选-去除未审查的问答
        queryset = super().get_all(**kwargs)
        return queryset.filter(status=True)

@api_controller('/issue')
class IssueModelController(ModelControllerBase):
    service_type = IssueService
    model_config = ModelConfig(
        model=Issue,
        # 修改检索Schema输出
        retrieve_schema=IssueRetrieveSchema,
        schema_config=ModelSchemaConfig(read_only_fields=['id', 'update_date', 'create_date'],
                                        depth=1),  # type:ignore
        pagination=ModelPagination(
            paginator_kwargs={
                'page_size': 10
            }
        )
    )
