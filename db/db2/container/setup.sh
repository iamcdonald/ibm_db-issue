#! /bin/bash

DATA_LOCATION=$1

set -e

echo "PASSWORD: $DB2INST1_PASSWORD"

su - db2inst1 -c db2start
su - db2inst1 -c "db2 -stvf /container/provision.sql"

su - db2inst1 -c db2stop
