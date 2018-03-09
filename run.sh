#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#./manage.py runserver_plus 0.0.0.0:8000
gunicorn config.wsgi -w 3 -b 0.0.0.0:8080
