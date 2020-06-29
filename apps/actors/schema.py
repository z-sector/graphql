import graphene
from graphene import ObjectType, Mutation
from graphene_django import DjangoObjectType
from graphql_jwt.decorators import login_required

from apps.actors.models import Actor


class ActorNode(DjangoObjectType):
    class Meta:
        model = Actor


class ActorsQuery(ObjectType):
    actor = graphene.Field(ActorNode, id=graphene.Argument(graphene.UUID, required=True), )
    actors = graphene.List(ActorNode)

    @login_required
    def resolve_actor(self, info, id, **kwargs):
        return Actor.objects.filter(pk=id).first()

    def resolve_actors(self, info, **kwargs):
        return Actor.objects.all()


class ActorCreateMutation(Mutation):
    class Arguments:
        name = graphene.String(required=True)

    actor = graphene.Field(ActorNode)

    def mutate(self, info, name):
        obj = Actor.objects.create(name=name)
        return ActorCreateMutation(actor=obj)


class ActorUpdateMutation(Mutation):
    class Arguments:
        name = graphene.String()
        id = graphene.UUID(required=True)

    actor = graphene.Field(ActorNode)

    def mutate(self, info, id, **kwargs):
        obj = Actor.objects.filter(id=id).first()
        if obj is None:
            return ActorCreateMutation(actor=obj)

        if kwargs.get('name'):
            obj.name = kwargs['name']
        obj.save()

        return ActorCreateMutation(actor=obj)


class ActorMutation:
    create_actor = ActorCreateMutation.Field()
    update_actor = ActorUpdateMutation.Field()
