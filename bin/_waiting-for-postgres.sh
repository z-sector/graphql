#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset




# CHECK ENV VARS
# ======================================================================================================

if [ -z "${POSTGRES_USER}" ]; then echo "-- invalid POSTGRES_USER. it was not specified"; exit 1; fi
if [ -z "${POSTGRES_PASSWORD}" ]; then echo "-- invalid POSTGRES_PASSWORD. it was not specified"; exit 1; fi
if [ -z "${POSTGRES_DB}" ]; then echo "-- invalid POSTGRES_DB. it was not specified"; exit 1; fi
if [ -z "${POSTGRES_HOST}" ]; then echo "-- invalid POSTGRES_HOST. it was not specified"; exit 1; fi
if [ -z "${POSTGRES_PORT}" ]; then echo "-- invalid POSTGRES_PORT. it was not specified"; exit 1; fi


echo "==============================================================="
echo "             POSTGRES_USER: ${POSTGRES_USER}"
echo "         POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}"
echo "               POSTGRES_DB: ${POSTGRES_DB}"
echo "             POSTGRES_HOST: ${POSTGRES_HOST}"
echo "             POSTGRES_PORT: ${POSTGRES_PORT}"
echo "==============================================================="



# INIT WORKING DIR
# ======================================================================================================

FILE_DIR=$(dirname "${BASH_SOURCE[0]}")
cd "$FILE_DIR"
FILE_DIR=$(pwd)
cd ../../
CWD=$(pwd)



# CHECK DB CONNECTION
# ======================================================================================================

postgres_ready() {
python3 << END
import sys
import psycopg2
try:
    connection = psycopg2.connect(
        dbname="${POSTGRES_DB}",
        user="${POSTGRES_USER}",
        password="${POSTGRES_PASSWORD}",
        host="${POSTGRES_HOST}",
        port="${POSTGRES_PORT}",
    )
except psycopg2.OperationalError as err:
    print(err)
    sys.exit(-1)
sys.exit(0)
END
}



COUNTER=0
until postgres_ready; do
  COUNTER=$((COUNTER+1))
  >&2 echo "Waiting for PostgreSQL to become available [$COUNTER] ..."
  if [ $COUNTER -gt 5 ]
 then
   exit 1
 fi
  sleep 1
done
>&2 echo 'PostgreSQL is available'



echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"
