import graphene
from graphene import ObjectType, relay, Connection
from graphene_django import DjangoObjectType
from graphene_django.filter import DjangoFilterConnectionField
from graphql_relay import from_global_id

from apps.movies.models import Movie, Category


class MovieNode(DjangoObjectType):
    movie_age = graphene.String()

    class Meta:
        model = Movie

    def resolve_movie_age(self, info):
        return "NEW" if self.year > 2015 else "OLD"


class ExtendedConnection(Connection):
    class Meta:
        abstract = True

    total_count = graphene.Int()

    def resolve_total_count(root, info, **kwargs):
        return root.length


class CategoryNode(DjangoObjectType):
    class Meta:
        model = Category
        interfaces = (relay.Node,)
        filter_fields = {
            'name': ['exact', 'icontains', 'istartswith'],
        }
        connection_class = ExtendedConnection


class CategoryUpdateMutationRelay(relay.ClientIDMutation):
    class Input:
        name = graphene.String()
        id = graphene.ID(required=True)

    category = graphene.Field(CategoryNode)

    @classmethod
    def mutate_and_get_payload(cls, root, info, id, **kwargs):
        obj = Category.objects.filter(id=from_global_id(id)[1]).first()
        if obj is None:
            return CategoryUpdateMutationRelay(category=obj)

        if kwargs.get('name'):
            obj.name = kwargs['name']
        obj.save()

        return CategoryUpdateMutationRelay(category=obj)


class MoviesQuery(ObjectType):
    movie = graphene.Field(MovieNode, id=graphene.Argument(graphene.UUID, required=True), )
    movies = graphene.List(MovieNode)
    all_categories = DjangoFilterConnectionField(CategoryNode)
    category = relay.Node.Field(CategoryNode)

    def resolve_movie(self, info, id, **kwargs):
        return Movie.objects.filter(pk=id).first()

    def resolve_movies(self, info, **kwargs):
        return Movie.objects.all()


class CategoryMutation:
    update_category = CategoryUpdateMutationRelay.Field()
