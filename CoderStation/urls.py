from django.urls import path, re_path
from django.views.static import serve
from django.conf import settings
from CoderStation.api import api

urlpatterns = [
    path('api/', api.urls),
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT})
]
