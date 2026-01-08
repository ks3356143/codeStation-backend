from typing import Optional
from django.contrib.auth import get_user_model
from ninja.errors import HttpError
from pydantic import field_validator, model_validator
from ninja import ModelSchema, FilterSchema, Schema, Field

User = get_user_model()

# ~~~~~~~~~~Mixin~~~~~~~~~~~
class UsernameValidationMixin:
    """用户名验证Mixin"""

    @field_validator("username")
    @classmethod
    def validate_username_unique(cls, v: str) -> str:
        if User.objects.filter(username=v).exists():
            raise HttpError(409, "用户名已经存在!")
        return v

class AvatarPathMixin:
    """头像路径处理Mixin"""

    @field_validator("avatar")
    @classmethod
    def normalize_avatar_path(cls, value: str) -> str:
        if value and value.startswith("/media/"):
            return value[7:]
        elif not value or value.strip() == "":
            return "user_avatar/default_avatar.png"
        return value

# ~~~~~~~~~~用户模块~~~~~~~~~~
# 1.输出：查询用户信息
class UserInfoOutSchema(ModelSchema):
    class Meta:
        model = User
        exclude = ['groups', 'user_permissions', 'is_superuser', 'is_staff', 'is_active']

# 2.搜索：搜索用户信息
class UserFilterSchema(FilterSchema):
    name: Optional[str] = Field(None, q='name__icontains')
    username: Optional[str] = Field(None, q='username__icontains')

# 3.新增：用户
class UserAddInputSchema(Schema, UsernameValidationMixin, AvatarPathMixin):
    username: str
    password: str
    name: str
    permission: Optional[int] = 2
    avatar: Optional[str] = "user_avatar/default_avatar.png"
    email: Optional[str] = ""
    qq: Optional[str] = ""
    wechat: Optional[str] = ""
    intro: Optional[str] = ""

# 4.修改：用户
class UserUpdateInputSchema(Schema, AvatarPathMixin):
    id: str
    username: str
    password: str
    name: str
    permission: Optional[int] = 2
    avatar: Optional[str] = "user_avatar/default_avatar.png"
    email: Optional[str] = ""
    qq: Optional[str] = ""
    wechat: Optional[str] = ""
    intro: Optional[str] = ""

    @model_validator(mode='after')
    def solve_id_username(self):
        user = User.objects.filter(username=self.username).first()
        if user:
            if user.id != self.id:
                raise HttpError(409, "用户名已经被占用，请重新输入!")
        else:
            raise HttpError(409, "无法修改用户名!")
        return self

# ~~~~~~~~~~管理员模块~~~~~~~~~~
# 2.输出：管理员信息
class AdminInfoOutSchema(ModelSchema):
    class Meta:
        model = User
        exclude = ['groups', 'user_permissions', 'is_superuser', 'is_staff', 'is_active']

# 3.输入：新增管理员
class AdminUpdateInputSchema(Schema, UsernameValidationMixin, AvatarPathMixin):
    username: str
    password: str
    name: str
    permission: Optional[int] = 1
    avatar: Optional[str] = "user_avatar/default_avatar.png"

# 3.输入：修改管理员
class AdminAddInputSchema(Schema):
    id: str
    username: str
    password: str
    name: str
    permission: Optional[int] = 1
    avatar: Optional[str] = "user_avatar/default_avatar.png"

    @model_validator(mode='after')
    def solve_id_username(self):
        user = User.objects.filter(username=self.username).first()
        if user.id != self.id:
            # 和其他用户名重复 - 多余工作
            raise HttpError(409, "用户名已经被占用，请重新输入!")
        return self
