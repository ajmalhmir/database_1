from django.http import JsonResponse
from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import UserProfile
from .serializers import UserProfileSerializer

from django.shortcuts import render


class UserProfileViewSet(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

def get_user_balance(request, email):
    try:
        user = UserProfile.objects.get(email=email)
        return JsonResponse({
            "email": user.email,
            "balance": user.balance
        })
    except UserProfile.DoesNotExist:
        return JsonResponse({"detail": "Not found."}, status=404)



def home_view(request):
    return render(request, 'home.html')

def admin_dashboard(request):
    users = UserProfile.objects.all()
    total_users = users.count()
    total_balance = sum(user.balance for user in users)

    user_names = [user.name for user in users]
    user_balances = [user.balance for user in users]

    return render(request, 'dashboard.html', {
        'users': users,
        'total_users': total_users,
        'total_balance': total_balance,
        'user_names': user_names,
        'user_balances': user_balances,
    })




