from django.db import models
from shortuuidfield import ShortUUIDField
from apps.user.models import User

class Issue(models.Model):
    """问答表"""
    id = ShortUUIDField(primary_key=True)
    issueTitle = models.CharField(max_length=128, verbose_name='问答标题')
    issueContent = models.TextField(max_length=10240, verbose_name='问答内容')
    # 关联用户，用户删除其问答删除
    user = models.ForeignKey(User, to_field="id", on_delete=models.CASCADE)
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_date = models.DateTimeField(auto_now=True, verbose_name='更新时间')
    # 审核是否通过，默认False
    status = models.BooleanField(default=False)
    # 浏览数量和评论数量
    commentNumber = models.IntegerField(default=0, verbose_name='评论数')
    scanNumber = models.IntegerField(default=0, verbose_name='浏览数')

class IssueType(models.Model):
    """问答类型表"""
    id = ShortUUIDField(primary_key=True)
    name = models.CharField(max_length=128, verbose_name='问答类型名称')

class Issue2Type(models.Model):
    """问答表和类型-多对多关系表"""
    iid = models.ForeignKey("Issue", on_delete=models.CASCADE, verbose_name='问答ID')
    tid = models.ForeignKey("IssueType", on_delete=models.CASCADE, verbose_name='问答类型ID')
