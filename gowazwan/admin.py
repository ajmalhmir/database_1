from django.contrib import admin
from .models import UserProfile

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('serial_number', 'name', 'phone', 'email', 'balance', 'last_login', 'url')

    def serial_number(self, obj):
        return obj.pk  # This shows ID as serial number
    serial_number.short_description = 'No.'
