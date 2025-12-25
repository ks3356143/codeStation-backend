from django.db import models
from django.contrib.auth.models import AbstractUser
from shortuuidfield import ShortUUIDField

class User(AbstractUser):
    # role字段区分是“管理员”还是“用户”
    id = ShortUUIDField(primary_key=True, verbose_name='用户唯一ID', help_text='用户唯一ID')
    username = models.CharField(max_length=150, unique=True, db_index=True, verbose_name='用户账号',
                                help_text="用户账号")
    name = models.CharField(max_length=40, verbose_name="姓名", help_text="姓名")
    avatar = models.ImageField(upload_to="user_avatar", verbose_name="用户头像", null=True, blank=True)
    type_choices = (('user', '用户'), ('admin', '管理员'))
    role = models.CharField(max_length=10, verbose_name='用户角色', help_text='用户角色', default='user',
                            choices=type_choices)
    permission = models.IntegerField(verbose_name='后台页面权限', help_text='后台页面权限', default=1)
    enabled = models.BooleanField(verbose_name='后台页面权限', help_text='后台页面权限', default=True)
    points = models.IntegerField(verbose_name='用户积分', default=0)

    def __str__(self):
        return f'用户：账号-{self.username},用户名名称-{self.name}'

    class Meta:
        db_table = 'user_user'
        verbose_name = '用户表'
        verbose_name_plural = verbose_name
        ordering = ('-id',)
