#!/bin/bash

# Navigate to your project
cd ~/database_1

# Activate the virtual environment
source venv/bin/activate

# Migrate any DB changes
python manage.py makemigrations --noinput
python manage.py migrate --noinput

# Fix static file permissions
sudo chown -R ubuntu:www-data ~/database_1/staticfiles

# Collect static files
python manage.py collectstatic --noinput

# Create superuser if it doesn't exist
python -c "import os; os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings'); import django; django.setup(); from django.contrib.auth.models import User; User.objects.filter(username='ajmal').exists() or User.objects.create_superuser('ajmal', 'ajmalhmir@gmail.com', 'ajmal')"

# Reload and restart backend
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
sudo systemctl reload nginx

