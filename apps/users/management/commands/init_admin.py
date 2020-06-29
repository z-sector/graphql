from typing import Any

from django.conf import settings
from django.core.management import BaseCommand
from django.contrib.auth import get_user_model

CustomUser = get_user_model()


class Command(BaseCommand):
    help = 'Utility to create a superuser'

    def handle(self, *args: Any, **options: Any) -> None:
        self.stdout.write(self.help)

        if not CustomUser.objects.first():
            username = settings.ADMIN_USERNAME
            password = settings.ADMIN_INITIAL_PASSWORD
            CustomUser.objects.create_superuser(username=username, password=password, email=None)
