"""信号：当Comment模型新增或删除，对应Issue模型的commentNumber字段需要变化"""
from django.db.models.signals import post_save, post_delete
from django.db.models import F
from django.dispatch import receiver
from apps.issue.models import Comment, Issue, Book

# 1.新增Comment的时候Issue的commentNumber+1
@receiver(post_save, sender=Comment)
def update_comment_count_on_create(sender, instance, created, **kwargs):
    if created and instance.issue_id:
        Issue.objects.filter(id=instance.issue_id).update(commentNumber=F('commentNumber') + 1)
    elif created and instance.book_id:
        Book.objects.filter(id=instance.book_id).update(commentNumber=F('commentNumber') + 1)

# 2.删除Commnet的时候Issue的commentNumber-1
@receiver(post_delete, sender=Comment)
def update_comment_count_on_delete(sender, instance, **kwargs):
    if instance.issue_id:
        Issue.objects.filter(id=instance.issue_id).update(commentNumber=F('commentNumber') - 1)
    elif instance.book_id:
        Book.objects.filter(id=instance.issue_id).update(commentNumber=F('commentNumber') - 1)
