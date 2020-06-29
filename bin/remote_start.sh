#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset

DOCKER_COMPOSE_FILE=docker-compose.dev.yml

# INIT WORKING DIR
# ======================================================================================================
cd "$(dirname "${BASH_SOURCE[0]}")"
FILE_DIR=$(pwd)
cd ../
CWD="$(pwd)"


# RUN START
# ===================================================
docker-compose -f ${DOCKER_COMPOSE_FILE} down --remove-orphans
docker-compose -f ${DOCKER_COMPOSE_FILE} build --parallel --force-rm
docker-compose -f ${DOCKER_COMPOSE_FILE} up -d
docker-compose -f ${DOCKER_COMPOSE_FILE} run --rm app python manage.py migrate
docker-compose -f ${DOCKER_COMPOSE_FILE} run --rm app python manage.py init_admin
docker image prune -f

echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"