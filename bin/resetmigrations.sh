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



# RUN RESETMIGRATIONS
# ===================================================
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
docker-compose run --rm app bash bin/_waiting-for-postgres.sh
docker-compose run --rm app python manage.py makemigrations


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"