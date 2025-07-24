#!/bin/bash
set -e

PROJECT_MAIN_DIR_NAME="database_1"

# Change directory to the project main directory
cd "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

# Activate virtual environment
echo "Activating virtual environment..."
source "/home/ubuntu/$PROJECT_MAIN_DIR_NAME/venv/bin/activate"

# Create superuser non-interactively
echo "Creating superuser..."
python -c "import os; os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings'); import django; django.setup(); from django.contrib.auth.models import User; User.objects.filter(username='ajmal').exists() or User.objects.create_superuser('ajmal', 'ajmalhmir@gmail.com', 'ajmal')"

echo "Superuser created successfully."