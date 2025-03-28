from django.db import models
from django.contrib.auth.models import AbstractUser
from shortuuidfield import ShortUUIDField

class User(AbstractUser):
    id = ShortUUIDField(primary_key=True, verbose_name='用户唯一ID', help_text='用户唯一ID')
    username = models.CharField(max_length=150, unique=True, db_index=True, verbose_name='用户账号',
                                help_text="用户账号")
    name = models.CharField(max_length=40, verbose_name="姓名", help_text="姓名")
    avatar = models.ImageField(upload_to="user_avatar", verbose_name="用户头像", null=True, blank=True)
    role = models.CharField(max_length=10, verbose_name='用户角色', help_text='用户角色', default='user')

    def __str__(self):
        return f'用户：账号-{self.username},用户名名称-{self.name}'

    class Meta:
        db_table = 'user_user'
        verbose_name = '用户表'
        verbose_name_plural = verbose_name
        ordering = ('-id',)
