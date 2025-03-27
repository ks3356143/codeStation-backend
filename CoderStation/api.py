from CoderStation.chen_ninja import ChenNinjaAPI
# 导入orjson解析器，渲染器，提升性能
from CoderStation.parser import MyParser
from CoderStation.renderer import MyRenderer
# 导入ninja_extra的APIException改造
from ninja_extra.exceptions import APIException, status
from ninja.errors import HttpError
from utils.chen_response import ChenResponse
from utils import code_list

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
    # 1.取出消息
    message = exc.detail['detail']
    # 2.取出状态码
    status_code = exc.status_code
    # 3.映射自己的code
    code = code_list.USERNAME_OR_PASSWORD_ERROR_CODE
    return ChenResponse(code=code, status=status_code, data='', message=message)

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
    return ChenResponse(code=code, status=status_code, data='', message=message)

# 自动找INSTALL_APPS里面的东西
api.auto_discover_controllers()
