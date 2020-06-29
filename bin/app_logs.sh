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




# RUN APP_LOGS
# ======================================================================================================
docker-compose logs --tail=500 --follow app


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"