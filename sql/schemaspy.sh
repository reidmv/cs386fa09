#!/bin/sh

SCHEMASPY_DIR="$HOME/bin/schemaspy"
SCHEMA_OUTDIR="./html"
DB_HOST="localhost"
DB_NAME="network_db"
DB_USER="marut"

[ -d "${SCHEMA_OUTDIR}" ] || mkdir "${SCHEMA_OUTDIR}"

java -jar ${SCHEMASPY_DIR}/schemaSpy_4.1.1.jar -t pgsql -host ${DB_HOST} -db ${DB_NAME} -s public -u ${DB_USER} -o ${SCHEMA_OUTDIR}/ -dp ${SCHEMASPY_DIR}/postgresql-8.3-604.jdbc3.jar -hq;
