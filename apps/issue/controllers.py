from apps.issue.models import Issue
from ninja_extra import (
    api_controller,
    ModelControllerBase,
    ModelEndpointFactory,
    ModelConfig
)
# schema和service导入
from apps.issue.schema import IssueListOutSchema
from apps.issue.service import IssueModelService
# 导入自己的分页
from utils.pagination import MyPageNumberPaginationExtra, MyPaginatedResponseSchema

# ~~~~问答模型~~~~
@api_controller('/issue')
class IssueModelController(ModelControllerBase):
    # 接口工程：条件查询所有Issue(注意屏蔽自动接口)
    list_issues = ModelEndpointFactory.list(
        path="/?enabled=str",
        schema_out=IssueListOutSchema,
        queryset_getter=lambda self, **kw: self.service.get_all(**kw),
        pagination_class=MyPageNumberPaginationExtra,
        pagination_response_schema=MyPaginatedResponseSchema,
        max_page_size=100,
        page_size=10,
        tags=['issuemodel-custom'],
        url_name='issue-list'
    )

    # 自定义操作服务
    service_type = IssueModelService
    model_config = ModelConfig(
        model=Issue,
        allowed_routes=["create", "find_one", "update", "patch", "delete"]
    )
