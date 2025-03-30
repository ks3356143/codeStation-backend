from datetime import timedelta

NINJA_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(hours=10),
    # 修改默认分页类
    'PAGINATION_CLASS': 'ninja_extra.pagination.PageNumberPaginationExtra'
}
