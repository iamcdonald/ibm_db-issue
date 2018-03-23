#! /bin/bash
COMPOSE_NAME=ibm_db_issue
CURR_DIR=$(pwd)
THIS_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
cd $THIS_DIR
docker-compose -p $COMPOSE_NAME up -d --build
POLL_DB_EXIT=`docker wait ${COMPOSE_NAME}_poll_db_1`
docker-compose -p $COMPOSE_NAME logs poll_db
cd $CURR_DIR
exit $POLL_DB_EXIT
