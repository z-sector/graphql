#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset



# INIT WORKING DIR
# ======================================================================================================
cd "$(dirname "${BASH_SOURCE[0]}")"
FILE_DIR=$(pwd)
cd ../
CWD="$(pwd)"


# RUN START
# ===================================================
docker-compose up -d
${FILE_DIR}/migrate.sh
docker-compose run --rm app python manage.py init_admin
docker-compose logs --tail=500 --follow


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"