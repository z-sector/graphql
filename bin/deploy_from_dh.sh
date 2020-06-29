#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset

DOCKER_HOST=ssh://ubuntu@157.230.122.132
DOCKER_COMPOSE_FILE=docker-compose.dev.yml

# INIT WORKING DIR
# ======================================================================================================
cd "$(dirname "${BASH_SOURCE[0]}")"
FILE_DIR=$(pwd)
cd ../
CWD="$(pwd)"


# RUN DEPLOY
# ===================================================
docker-compose -f ${DOCKER_COMPOSE_FILE} -H ${DOCKER_HOST} up -d


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"