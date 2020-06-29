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



# RUN INIT
# ===================================================
docker-compose down -v
${FILE_DIR}/resetmigrations.sh
${FILE_DIR}/start.sh


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"