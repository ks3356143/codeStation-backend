from apps.user.models import User
from ninja import ModelSchema

# 1.输出：查询用户信息
class UserInfoOutSchema(ModelSchema):
    class Meta:
        model = User
        exclude = ['id', 'password', 'groups', 'user_permissions', 'is_superuser', 'is_staff', 'is_active']
