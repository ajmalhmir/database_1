from django.db import models

class UserProfile(models.Model):
    name = models.CharField(max_length=100)
    phone = models.CharField(max_length=15)
    email = models.EmailField(unique=True)
    balance = models.DecimalField(max_digits=10, decimal_places=2)
    last_login = models.DateTimeField(auto_now=True)
    url = models.URLField(blank=True)

    def __str__(self):
        return self.name
