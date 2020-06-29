import graphene

from apps.actors.schema import ActorsQuery, ActorMutation
from apps.movies.schema import MoviesQuery, CategoryMutation
from apps.users.schema import TokenMutation


class Query(ActorsQuery, MoviesQuery, graphene.ObjectType):
    pass


class Mutation(ActorMutation, TokenMutation, CategoryMutation, graphene.ObjectType):
    pass


schema = graphene.Schema(query=Query, mutation=Mutation)
