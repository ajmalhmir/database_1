#!/bin/bash
set -e

PROJECT_MAIN_DIR_NAME="database_1"

# Change directory to the project main directory
cd "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

# Activate virtual environment
echo "Activating virtual environment..."
source "/home/ubuntu/$PROJECT_MAIN_DIR_NAME/venv/bin/activate"

# Ensure database directory has proper permissions
echo "Setting up database permissions..."
touch db.sqlite3
chmod 664 db.sqlite3
sudo chown -R ubuntu:www-data .

# Run migrations to ensure database tables exist
echo "Running database migrations..."
python manage.py makemigrations --noinput
python manage.py migrate --noinput

# Create superuser non-interactively
echo "Creating superuser..."
python -c "import os; os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings'); import django; django.setup(); from django.contrib.auth.models import User; User.objects.filter(username='ajmal').exists() or User.objects.create_superuser('ajmal', 'ajmalhmir@gmail.com', 'ajmal')"

echo "Superuser created successfully."