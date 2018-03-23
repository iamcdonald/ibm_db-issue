#! /bin/bash

set -e

su - db2inst1 -c db2start

tail -f ~db2inst1/sqllib/db2dump/db2diag.log &
export pid=${!}
while true
do
  sleep 10000 &
  export spid=${!}
  wait $spid
done
