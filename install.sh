#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "# INSTALL"

pip install -r requirements/local.txt
