from ninja_extra import api_controller, route
from ninja_jwt.controller import TokenObtainPairController
from django.contrib.auth import get_user_model
from ninja_jwt.authentication import JWTAuth
from utils.chen_response import ChenResponse
# schemas imports
from apps.user.schema import UserInfoOutSchema

User = get_user_model()  # type:ignore

@api_controller("/user", tags=['用户登录注册接口'])
class UserJWTController(TokenObtainPairController):
    auto_import = True  # 自动导入到接口

    # 获取用户信息接口
    @route.get("/get_info", response=UserInfoOutSchema, auth=JWTAuth(), url_name='user_get_info')
    def get_info(self):
        return 200, self.context.request.auth  # type:ignore

    # 用户退出登录，前端不储存JWT令牌即可退出登录
    @route.post("/logout", url_name='user_logout', auth=JWTAuth())
    def logout(self):
        return ChenResponse(message='退出登录成功', data="", code=200)
