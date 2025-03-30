from apps.user.models import User
from apps.issue.models import Issue, IssueType
from ninja import ModelSchema

# list：问答接口Schemas
class NestUserOutSchema(ModelSchema):
    class Meta:
        model = User
        fields = ['id', 'username', 'name']

class NestTypeOutSchema(ModelSchema):
    class Meta:
        model = IssueType
        fields = "__all__"

class IssueListOutSchema(ModelSchema):
    user: NestUserOutSchema
    type: NestTypeOutSchema

    class Meta:
        model = Issue
        exclude = ['user', 'type']
