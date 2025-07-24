from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse
from django.shortcuts import render
from gowazwan.views import admin_dashboard, home_view  # ✅ import both views

urlpatterns = [
    path('', home_view, name='home'),                      # 🏠 shows home.html (profile page)
    path('dashboard/', admin_dashboard, name='dashboard'),# 📊 shows dashboard.html (admin panel)
    path('api/', include('gowazwan.urls')),                # your API
    path('admin/', admin.site.urls),                       # Django admin
]
