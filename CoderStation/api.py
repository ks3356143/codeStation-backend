from CoderStation.chen_ninja import ChenNinjaAPI
# 导入orjson解析器，渲染器，提升性能
from CoderStation.parser import MyParser
from CoderStation.renderer import MyRenderer
# 导入ninja_extra的APIException改造
from ninja_extra.exceptions import APIException
from ninja.errors import HttpError
from utils.chen_response import ChenResponse
from utils import code_list
from ninja_extra.exceptions import ErrorDetail
from ninja.errors import ValidationError

api = ChenNinjaAPI(
    title='CodeStation问答平台',
    description='问答平台接口',
    urls_namespace="code_station",
    parser=MyParser(),
    renderer=MyRenderer()
)

# 转换ninja_extra的报错同一出口
@api.exception_handler(APIException)
def transform_extra_exception(request, exc):
    message = '未知错误!!!'
    code = code_list.USERNAME_OR_PASSWORD_ERROR_CODE
    if isinstance(exc.detail, ErrorDetail):
        # 1.判断是否为分页404错误
        message = exc.detail.replace('Invalid page. ', '错误的页面参数:')
        code = code_list.QUERY_NOTHING_ERROR_CODE
    else:
        message = exc.detail['detail']
    # 2.取出状态码
    status_code = exc.status_code
    return ChenResponse(code=code, status=status_code, data='', message=message, success=False)

# 转换ninja_jwt的认证失败错误统一出口
@api.exception_handler(HttpError)
def transform_jwt_exception(request, exc):
    # 1.取出消息
    message = exc.message
    # 2.取出状态码
    status_code = exc.status_code
    # 判断消息
    code = 20000
    if message == 'Unauthorized':
        code = code_list.USER_UNAUTHORIZATION_ERRRR_CODE
        message = '用户没有经过授权就访问'
    return ChenResponse(code=code, status=status_code, data='', message=message, success=False)

# 捕获pydantic的Validation异常
@api.exception_handler(ValidationError)
def transform_validation_error_exception(request, exc):
    code = code_list.PARAMS_TYPE_OR_REQUIRED_ERROR_CODE
    status_code = 422
    message = "您的参数输入缺省或类型错误"
    return ChenResponse(code=code, status=status_code, data='', message=message, success=False)

# 自动找INSTALL_APPS里面的东西
api.auto_discover_controllers()
