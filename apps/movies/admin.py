from django.contrib import admin

from apps.movies.models import Movie, Category


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'id', 'date_created', 'date_modified')
    ordering = ('name',)


class ActorsInline(admin.TabularInline):
    model = Movie.actors.through


@admin.register(Movie)
class MovieAdmin(admin.ModelAdmin):
    inlines = [
        ActorsInline,
    ]
    list_display = ('title', 'category', 'year', 'id', 'date_created', 'date_modified')
    ordering = ('title',)
