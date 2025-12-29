from typing import Optional
from django.contrib.auth import get_user_model
from ninja.errors import HttpError
from pydantic import field_validator, model_validator
from ninja import ModelSchema, FilterSchema, Schema, Field

User = get_user_model()

# ~~~~~~~~~~用户模块~~~~~~~~~~
# 1.输出：查询用户信息
class UserInfoOutSchema(ModelSchema):
    class Meta:
        model = User
        exclude = ['groups', 'user_permissions', 'is_superuser', 'is_staff', 'is_active',
                   'role']

# 2.搜索：搜索用户信息
class UserFilterSchema(FilterSchema):
    name: Optional[str] = Field(None, q='name__icontains')
    username: Optional[str] = Field(None, q='username__icontains')

# ~~~~~~~~~~管理员模块~~~~~~~~~~
# 2.输出：管理员信息
class AdminInfoOutSchema(ModelSchema):
    class Meta:
        model = User
        exclude = ['groups', 'user_permissions', 'is_superuser', 'is_staff', 'is_active']

# 3.输入：新增管理员
class AdminUpdateInputSchema(Schema):
    username: str
    password: str
    name: str
    permission: Optional[int] = 1
    avatar: Optional[str] = "user_avatar/hsq.jpg"

    # 处理验证用户名是否存在
    @field_validator("username")
    @classmethod
    def is_user_exit(cls, v: str) -> str:
        if User.objects.filter(username=v).exists():
            raise HttpError(409, "用户名已经存在!")
        return v

    # 处理avatar前置/media问题
    @field_validator("avatar")
    @classmethod
    def avatar_solve_path(cls, value: str) -> str | None:
        if value and value.startswith("/media/"):
            return value[7:]
        elif value.strip() == "":
            return "user_avatar/default_avatar.png"
        return value

# 3.输入：修改管理员
class AdminAddInputSchema(Schema):
    id: str
    username: str
    password: str
    name: str
    permission: Optional[int] = 1
    avatar: Optional[str] = "user_avatar/hsq.jpg"

    @model_validator(mode='after')
    def solve_id_username(self):
        user = User.objects.filter(username=self.username).first()
        if user.id != self.id:
            # 和其他用户名重复 - 多余工作
            raise HttpError(409, "用户名已经被占用，请重新输入!")
        return self
