from ninja import FilterSchema, Field
from typing import Optional

# 1、搜索issue的标题和内容
class IssueFilterSchema(FilterSchema):
    searchValue: Optional[str] = Field("")
    searchOption: Optional[str] = Field("issue")

# 2、搜索book的标题和内容
class BookFilterSchema(FilterSchema):
    searchValue: Optional[str] = Field("")
    searchOption: Optional[str] = Field("book")
