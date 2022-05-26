#!/bin/sh

set -e

. /venv/bin/activate

python -m riemann.setup --migrate

exec gunicorn -k uvicorn.workers.UvicornWorker riemann.asgi:application --bind 0.0.0.0:8000