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



# RUN MIGRATE
# ===================================================

docker-compose run --rm app python manage.py createsuperuser


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"