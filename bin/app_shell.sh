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




# RUN
# ======================================================================================================

docker-compose run --rm app /bin/bash


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"
