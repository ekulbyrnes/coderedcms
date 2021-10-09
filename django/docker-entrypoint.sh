#!/bin/sh

echo "Initialising CodeRedCMS..."
coderedcms start st_survival --sitename "Star Trek: Survival" --domain "https://st-s.scouthack.com"

echo "Performing Django database migrations (if any)"
python manage.py migrate --no-input

echo "Copying static files"
python manage.py collectstatic --no-input --clear

# Creat a super user
python manage.py shell -c 'from scripts import createsuperuser; createsuperuser.run()'

# Execute the CMD from the Dockerfile:
exec "$@"
