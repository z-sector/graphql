#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"


RED='\033[0;31m'
NC='\033[0m'

# RUN DOCKER_PRUNE
# ===================================================
docker system df -v

echo "CONTAINER STOP:"
docker container stop $(docker container ls -aq)
echo "CONTAINER RM:"
docker container rm $(docker container ls -aq)
echo -e "${RED}DELETED:${NC}"
docker system prune -a -f --volumes


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"