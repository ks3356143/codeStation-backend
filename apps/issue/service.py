import typing as t
from django.db.models import QuerySet
from ninja_extra import ModelService

# ~~~~1.问答模型~~~~
class IssueModelService(ModelService):
    def get_all(self, **kwargs: t.Any) -> t.Union[QuerySet, t.List[t.Any]]:
        issues = self.model.objects.all()
        # status字段筛选
        enabled = kwargs.get('enabled')
        status = True
        if enabled:
            if enabled.lower() in ('false', '0', 'undefined', 'null'):
                status = False
        return issues.filter(status=status)
