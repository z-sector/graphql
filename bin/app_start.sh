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



# WAITING FOR POSTGRES
# ======================================================================================================
${FILE_DIR}/_waiting-for-postgres.sh



# RUN APP_START
# ======================================================================================================
WORKERS_COUNT=$(expr 1 + $(grep -c ^processor /proc/cpuinfo))
echo "WORKERS_COUNT=${WORKERS_COUNT}"

export PYTHONPATH="${CWD}"

gunicorn -w ${WORKERS_COUNT} --timeout 120 apps_config.wsgi -b 0.0.0.0:8000 --capture-output --access-logfile - --reload

