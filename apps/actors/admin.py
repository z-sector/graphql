from django.contrib import admin

from apps.actors.models import Actor
from apps.movies.admin import ActorsInline


@admin.register(Actor)
class ActorAdmin(admin.ModelAdmin):
    inlines = [ActorsInline, ]
    list_display = ('name', 'id', 'date_created', 'date_modified')
    ordering = ('name',)
