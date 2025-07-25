#!/usr/bin/env bash
set -e

PROJECT_MAIN_DIR_NAME="database_1"

# Validate variables
if [ -z "$PROJECT_MAIN_DIR_NAME" ]; then
    echo "Error: PROJECT_MAIN_DIR_NAME is not set. Please set it to your project directory name." >&2
    exit 1
fi

# Change ownership to ubuntu user
sudo chown -R ubuntu:ubuntu "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

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

# Run collectstatic command
echo "Running collectstatic command..."
python manage.py collectstatic --noinput

# Restart Gunicorn and Nginx services
echo "Restarting Gunicorn and Nginx services..."
sudo service gunicorn restart
sudo service nginx restart

echo "Application started successfully."
