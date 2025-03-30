from typing import Optional, List, Any, Generic, TypeVar
from ninja import Schema
from ninja_extra.pagination import PageNumberPaginationExtra
from collections import OrderedDict
from django.core.paginator import Page
from ninja.types import DictStrAny
from ninja_extra.schemas.response import Url

# 修改extra的PageNumberPaginationExtra，目的是修改输出包含内容
class MyPageNumberPaginationExtra(PageNumberPaginationExtra):
    def get_paginated_response(self, *, base_url: str, page: Page) -> DictStrAny:
        return OrderedDict(
            [
                ("count", page.paginator.count),
                ("next", self.get_next_link(base_url, page=page)),
                ("previous", self.get_previous_link(base_url, page=page)),
                ("results", list(page)),
                # 新增外层返回字段
                ("page_size", self.page_size),
                ("current_page", page.number),
                ("total_pages", page.paginator.num_pages),
            ]
        )

# 这里定义分页响应的基础结构
T = TypeVar("T")

class CustomBasePaginatedResponseSchema(Schema):
    # 新增page_size、current_page、total_pages字段/老4个字段不变
    page_size: Optional[int]
    current_page: Optional[int]
    count: int
    total_pages: Optional[int]
    next: Optional[Url]
    previous: Optional[Url]
    results: List[Any]

# 修改PaginatedResponseSchema中Base的结构
class MyPaginatedResponseSchema(CustomBasePaginatedResponseSchema, Generic[T]):
    results: List[T]
