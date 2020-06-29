import uuid

from django.db import models

from apps.actors.models import Actor


class Category(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    date_created = models.DateTimeField(auto_now_add=True, editable=False)
    date_modified = models.DateTimeField(auto_now=True, editable=False)
    name = models.CharField(max_length=100)

    class Meta:
        ordering = ('name',)

    def __str__(self):
        return f'{self.name}'


class Movie(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    date_created = models.DateTimeField(auto_now_add=True, editable=False)
    date_modified = models.DateTimeField(auto_now=True, editable=False)
    title = models.CharField(max_length=100)
    actors = models.ManyToManyField(Actor, through='ActorMovie')
    year = models.IntegerField()
    category = models.ForeignKey(Category, on_delete=models.PROTECT, default=None, null=True)

    class Meta:
        ordering = ('title',)

    def __str__(self):
        return f'{self.title}'


class ActorMovie(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    date_created = models.DateTimeField(auto_now_add=True, editable=False)
    date_modified = models.DateTimeField(auto_now=True, editable=False)
    actor = models.ForeignKey(Actor, on_delete=models.PROTECT, )
    Movie = models.ForeignKey(Movie, on_delete=models.PROTECT, )
