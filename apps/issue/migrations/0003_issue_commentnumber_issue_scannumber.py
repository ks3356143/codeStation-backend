# Generated by Django 5.1.7 on 2025-03-31 16:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('issue', '0002_alter_issue_update_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='issue',
            name='commentNumber',
            field=models.IntegerField(default=0, verbose_name='评论数'),
        ),
        migrations.AddField(
            model_name='issue',
            name='scanNumber',
            field=models.IntegerField(default=0, verbose_name='浏览数'),
        ),
    ]
