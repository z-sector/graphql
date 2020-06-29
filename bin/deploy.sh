#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset

DEPLOYMENT_IP=134.122.89.253
REMOTE_DIR=ai_demo_tool

# INIT WORKING DIR
# ======================================================================================================
cd "$(dirname "${BASH_SOURCE[0]}")"
FILE_DIR=$(pwd)
cd ../
CWD="$(pwd)"


# RUN DEPLOY
# ===================================================
COMMAND_FIND="find . -not -path \"./.var/*\" -not -path \"./.var\" -not -path \".\" -delete"
scp -o ConnectTimeout=30 -o StrictHostKeyChecking=no -P 22 -r ${CWD}/[!.]* ubuntu@${DEPLOYMENT_IP}:~/${REMOTE_DIR}
ssh -T ubuntu@${DEPLOYMENT_IP} "cd ${REMOTE_DIR} && ./bin/remote_start.sh && ${COMMAND_FIND}"


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"