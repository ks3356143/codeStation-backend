import datetime

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

# 书籍类型：1为问答评论，2为书籍评论
comment_type_coices = ((1, '问答'), (2, '书籍'))

class Comment(models.Model):
    """评论模型"""
    id = ShortUUIDField(primary_key=True)
    user = models.ForeignKey(User, to_field="id", on_delete=models.CASCADE)
    # 因为评论类型为2时候为书籍评论，此项应该为null
    issue = models.ForeignKey(Issue, to_field='id', on_delete=models.CASCADE, null=True)
    type = models.ManyToManyField(IssueType, verbose_name='评论关联的问答类型')
    commentType = models.SmallIntegerField(verbose_name='评论类型', default=1, choices=comment_type_coices)
    commentContent = models.TextField(max_length=10240, verbose_name='评论内容')
    # book关联书籍-后面添加
    book = models.ForeignKey('Book', to_field='id', on_delete=models.CASCADE, null=True)
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_date = models.DateTimeField(auto_now=True, verbose_name='更新时间')

class Quiz(models.Model):
    """考试题模型"""
    id = ShortUUIDField(primary_key=True)
    quizTitle = models.CharField(max_length=128, verbose_name='考试题标题')
    quizContent = models.TextField(max_length=10240, verbose_name='考试题内容')
    type = models.ForeignKey(IssueType, to_field='id', on_delete=models.CASCADE)
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_date = models.DateTimeField(auto_now=True, verbose_name='更新时间')

class Book(models.Model):
    """书籍"""
    id = ShortUUIDField(primary_key=True)
    title = models.CharField(max_length=128, verbose_name='书籍标题')
    picture = models.ImageField(upload_to="book_imgs", verbose_name="书籍图片", null=True, blank=True)
    downloadLink = models.CharField(max_length=512, verbose_name='书籍下载链接', null=True, blank=True)
    bookInfo = models.TextField(max_length=10240, verbose_name='书籍介绍')
    type = models.ForeignKey(IssueType, to_field='id', verbose_name='书籍对应的类型',
                             on_delete=models.CASCADE)
    requirePoints = models.IntegerField(default=0, verbose_name='书籍查看需要的分数')
    # 浏览数量和评论数量
    commentNumber = models.IntegerField(default=0, verbose_name='评论数')
    scanNumber = models.IntegerField(default=0, verbose_name='浏览数')
    create_date = models.DateTimeField(auto_now_add=True, verbose_name='创建时间', null=True, blank=True)
