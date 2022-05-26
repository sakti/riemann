import argparse
import os

import django
from django.core.management import call_command

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "riemann.settings")
django.setup()

parser = argparse.ArgumentParser(description="setup script for django without using manage.py")
parser.add_argument("--static", action="store_true", default=False)
parser.add_argument("--migrate", action="store_true", default=False)
parser.add_argument("--superuser", action="store_true", default=False)


def main() -> None:
    args = parser.parse_args()
    if args.static:
        call_command("collectstatic", interactive=False)
    if args.migrate:
        call_command("migrate", interactive=False)
    if args.superuser:
        call_command("createsuperuser", interactive=True)


if __name__ == "__main__":
    main()
