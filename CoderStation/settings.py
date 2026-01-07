from pathlib import Path
import os
# 导入NINJA_JWT配置
from CoderStation.conf.jwt_config import *

# 项目目录
BASE_DIR = Path(__file__).resolve().parent.parent
# 密钥
SECRET_KEY = 'django-insecure-wod@7&)wc3rgj8%3f5(o!t!!%@^4u9&-ukc=#j5ambi97mxa6u'
# warning：注意生成环境变为False
DEBUG = True

ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.staticfiles',
    'ninja',
    'ninja_extra',
    'ninja_jwt',
    'apps.user',
    'apps.issue'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'CoderStation.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates']
        ,
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [],
        },
    },
]

WSGI_APPLICATION = 'CoderStation.wsgi.application'

# 数据库配置
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "NAME": "codeStation",
        "USER": 'root',
        'PASSWORD': 'root',
        "HOST": "127.0.0.1",
        "PORT": '3306'
    }
}

LANGUAGE_CODE = 'zh-hans'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_TZ = False

STATIC_URL = 'static/'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Media配置
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

# User表配置
AUTH_USER_MODEL = 'user.User'
USERNAME_FIELD = 'username'

# 配置跨域
CORS_ALLOW_ALL_ORIGINS = True

# ninja_extra配置
## 配置默认分页器
NINJA_EXTRA = {
    'PAGINATION_CLASS': 'ninja_extra.pagination.PageNumberPaginationExtra'
}

# ninja_jwt配置
NINJA_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(hours=2),  # 访问令牌时间
    'REFRESH_TOKEN_LIFETIME': timedelta(days=1),  # 刷新令牌时间
}
