#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#./manage.py runserver_plus 0.0.0.0:8000
gunicorn config.wsgi -b 0.0.0.0:8080
