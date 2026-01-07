from django.db.models import Q
from ninja import FilterSchema, Field
from typing import Optional, Literal

# 1、搜索issue的标题和内容
class IssueFilterSchema(FilterSchema):
    searchValue: Optional[str] = Field("")
    searchOption: Optional[str] = Field("issue")

# 2、搜索book的标题和内容
class BookFilterSchema(FilterSchema):
    searchValue: Optional[str] = Field("")
    searchOption: Optional[str] = Field("book")
    type: Optional[str] = Field("all")

# 3、搜索quiz的标题和分类
class QuizFilterSchema(FilterSchema):
    quizTitle: Optional[str] = Field("")
    type: Optional[str] = Field("all")

# 4、搜索评论的类型和内容
class CommentFilterSchema(FilterSchema):
    commentType: Optional[Literal['1', '2']] = None
    commentContent: Optional[str] = Field("", q="commentContent__icontains")
    type: Optional[str] = "all"

    def filter_type(self, value) -> Q:
        if value == 'all' or value is None:
            return Q()
        return Q(type__id=value)
