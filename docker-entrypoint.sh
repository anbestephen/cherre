#!/bin/bash

apt-get update
apt-get install -y git
pip install --upgrade pip
pip install -r requirements.txt
python manage.py collectstatic --noinput
python manage.py migrate --no-input
touch ./logs/gunicorn.log
touch ./logs/gunicorn-access.log
tail -n 0 -f ./logs/gunicorn*.log &

gunicorn --bind 0.0.0.0:8000 my_project.wsgi:application --log-level=info --log-file=./logs/gunicorn.log --access-logfile=./logs/gunicorn-access.log

exec "$@"
