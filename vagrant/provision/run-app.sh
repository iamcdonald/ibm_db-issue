cd /opt/nodejs/ibm_db-issue

HOST=localhost DBPWD=db2inst1 npm run test:only:base
HOST=localhost DBPWD=db2inst1 npm run test:file:only:base