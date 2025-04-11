from apps.user.models import User
from apps.issue.models import Issue, Issue2Type, IssueType, Comment, Quiz
from ninja import ModelSchema, Schema
from typing import List

# 预制type
class TypeModelSchema(ModelSchema):
    class Meta:
        model = IssueType
        fields = '__all__'

# list：问答接口Schemas
class NestUserOutSchema(ModelSchema):
    class Meta:
        model = User
        fields = ['id', 'username', 'name']

class IssueListOutSchema(ModelSchema):
    user: NestUserOutSchema
    create_date: str
    type: List[str] = []

    @staticmethod
    def resolve_create_date(obj):
        return obj.create_date.strftime("%Y-%m-%d %H:%M:%S")

    @staticmethod
    def resolve_type(obj):
        qs = Issue2Type.objects.filter(iid__id=obj.id).select_related("tid")
        # 使用select_related联表查询已经查询了一个大表，性能优化多次查询了（联表查询）
        # 其他知识：prefetch_related适合（查询两次，第一次主对象，第二次所有辅对象，然后在python连接关系）
        # 以上两种都是在需要使用for循环，遍历当前表关联的其他表的属性时候
        type_list = [t.tid.name for t in qs]
        return type_list

    class Meta:
        model = Issue
        exclude = ['user']

# 这个和上面区别是type返回的不是python而是问答类型的id
class IssueRetrieveOutSchema(ModelSchema):
    user: NestUserOutSchema
    create_date: str
    type: List[str] = []

    @staticmethod
    def resolve_create_date(obj):
        return obj.create_date.strftime("%Y-%m-%d %H:%M:%S")

    @staticmethod
    def resolve_type(obj):
        qs = Issue2Type.objects.filter(iid__id=obj.id).select_related("tid")
        type_list = [t.tid.id for t in qs]
        return type_list

    class Meta:
        model = Issue
        exclude = ['user']

# 新增/修改Schema
class IssueCreateSchema(ModelSchema):
    type_id: str
    user_id: str

    class Meta:
        model = Issue
        fields = ['issueTitle', 'issueContent']

# ~~~~Comment Schema~~~~
class CommentOutSchema(ModelSchema):
    class Meta:
        model = Comment
        fields = "__all__"

# ~~~~Quiz Schema~~~~
class QuizTitleSchema(Schema):
    id: str
    quizTitle: str

class QuizOnlyTitleSchema(Schema):
    type: TypeModelSchema
    titles: list[QuizTitleSchema]
