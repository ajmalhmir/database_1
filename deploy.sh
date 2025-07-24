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

# Reload and restart backend
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
sudo systemctl reload nginx

