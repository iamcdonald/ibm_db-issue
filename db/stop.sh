#! /bin/bash
COMPOSE_NAME=dbs
CURR_DIR=$(pwd)
THIS_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
cd $THIS_DIR
docker-compose -p $COMPOSE_NAME kill
docker-compose -p $COMPOSE_NAME rm -f
cd $CURR_DIR
