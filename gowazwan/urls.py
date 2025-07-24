from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserProfileViewSet, get_user_balance, admin_dashboard


router = DefaultRouter()
router.register(r'users', UserProfileViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('users/balance/<str:email>/', get_user_balance, name='get_user_balance'),
     path('dashboard/', admin_dashboard, name='admin_dashboard'),
]
