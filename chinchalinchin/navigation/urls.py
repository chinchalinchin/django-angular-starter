from django.urls import path

from . import views

app_name='navigation'

urlpatterns = [
    path('', views.splash_page, name='splash'),
    path('home/', views.home_page, name='home')
]