#! /bin/bash

HOST=$1
PORT=$2
echo "polling ${HOST}:${PORT} ..."
POLL_FREQ=3
POLL_LIMIT=10
POLL_COUNT=0

until ( nc -v -z $HOST $PORT || [ $POLL_COUNT -eq $POLL_LIMIT ] ); do
    ((POLL_COUNT++))
    echo $POLL_COUNT
    sleep $POLL_FREQ
done
