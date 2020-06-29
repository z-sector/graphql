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



# RUN STOP
# ===================================================
docker-compose stop


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"