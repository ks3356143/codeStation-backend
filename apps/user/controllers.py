from pathlib import Path
from ninja import UploadedFile, File
from ninja_extra import api_controller, route
from ninja.errors import HttpError
from ninja_jwt.controller import TokenObtainPairController
from django.contrib.auth import get_user_model
from ninja_jwt.authentication import JWTAuth
from utils.chen_response import ChenResponse
# schemas imports
from apps.user.schema import UserInfoOutSchema, AdminInfoOutSchema, AdminUpdateInputSchema, \
    AdminAddInputSchema

User = get_user_model()  # type:ignore

@api_controller("/user", tags=['用户登录注册接口'])
class UserJWTController(TokenObtainPairController):
    auto_import = True  # 自动导入到接口

    # 获取用户信息接口-当前登录用户
    @route.get("/get_info", response=UserInfoOutSchema, auth=JWTAuth(), url_name='user_get_info')
    def get_info(self):
        return 200, self.context.request.auth  # type:ignore

    # 获取用户信息-传入user_id
    @route.get("/get_info_by_id", response=UserInfoOutSchema, url_name='user_get_info_by_id')
    def get_info_by_id(self, user_id: str):
        instance = User.objects.filter(id=user_id).first()
        return instance

    # 用户退出登录，前端不储存JWT令牌即可退出登录
    @route.post("/logout", url_name='user_logout', auth=JWTAuth())
    def logout(self):
        return ChenResponse(message='退出登录成功', data="", code=200)

    # 获取积分前十的用户
    @route.get("/points_rank", response=list[UserInfoOutSchema], url_name='user_points_rank')
    def points_rank(self):
        return User.objects.order_by('-points')[:10].iterator()

    # 新增修改用户头像
    @route.post("/avatar", response=str, url_name='user_avatar')
    def modify_avatar(self, user_id: str, file: UploadedFile = File(...)):
        user_obj = User.objects.filter(id=user_id).first()
        if user_obj.avatar:  # 检查是否有旧头像
            user_obj.avatar.delete()  # 删除文件系统中的文件
        user_obj.avatar = file
        user_obj.save()
        return ChenResponse(code=200, data=user_obj.avatar.url)  # type:ignore

    # 修改用户name字段
    @route.get("/modify_name", response=str, url_name='user_modify_name')
    def modify_name(self, user_id: str, name: str):
        user_obj = User.objects.filter(id=user_id).first()
        if user_obj:
            user_obj.name = name
            user_obj.save()
        return ChenResponse(code=200, data=user_obj.name)

    # ~~~~~~~~管理员相关控制~~~~~~~~
    # 获取所有管理员
    @route.get("/admin", response=list[AdminInfoOutSchema], url_name='admin_all')
    def get_all_admin(self):
        return User.objects.filter(role='admin').all()

    # 某个管理员权限改变
    @route.get("/admin_enabled_change", response=str, url_name='admin_enabled')
    def change_enabled(self, admin_id: str):
        # 根据admin的id查询
        admin_one = User.objects.filter(id=admin_id).first()
        if admin_one:
            admin_one.enabled = not admin_one.enabled
            admin_one.save()
        return ChenResponse(code=200, data='修改成功')

    # 删除某个管理员
    @route.delete("/admin_delete/{admin_id}")
    def delete_admin(self, admin_id: str):
        admin = User.objects.filter(id=admin_id).first()
        if admin.is_superuser:
            raise HttpError(403, "权限：无法删除唯一的超级管理员")
        admin.avatar.delete()
        admin.delete()
        return ChenResponse(code=200, data='删除成功')

    # 修改管理员
    @route.patch("/admin/{id}")
    def modify_admin(self, id: str, data: AdminAddInputSchema):
        update_data = data.dict(exclude={"id", "username", "password"})
        user = User.objects.get(id=id)
        for key, value in update_data.items():
            if hasattr(user, key):
                setattr(user, key, value)
        user.set_password(data.password)
        user.save()
        return ChenResponse(code=200, data="修改成功")

    # 新增管理员
    @route.post("/admin/add/")
    def add_admin(self, data: AdminUpdateInputSchema):
        extra_fields = data.dict()
        extra_fields["role"] = "admin"
        User.objects.create_user(username=extra_fields.pop("username"),
                                 password=extra_fields.pop("password"),
                                 **extra_fields)
        return ChenResponse(code=200, data='新增成功')
