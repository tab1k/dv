from .views import *
from django.urls import path, include

app_name = 'app'

urlpatterns = [
    path('', HomePageView.as_view(), name="home"),
    path('vuz-verify/iin=020923500581/', CheckVuzPageView.as_view(), name="check")
]