# Reproducing Memory Issues

Reproducing a memory issue seen in a larger application.

Upon trying to persist some data-sets to a BLOB field within a db2 database various memory (within the binding layer) and Segmentation Faults are produced.

It isn't always the same error but it will, a majority of the time, cause the node process to abort.

# Commands

`npm run test` will
- create and start a db2 database with a single table in it with a auto generated id column and a blob field;
- run the tests within another docker container running node 8 against this db with both debug settings on (node and bindings).
- stop the db2 instance

`npm run deps:start`
- run the db2 container mentioned above

`npm run deps:stop`
- stop the db2 container mentioned above

`npm run test:only`
- run the test showing memory issue with small string
- ran in a node 8 docker container against the db2 container

`npm run test:file:only`
- run the test showing potentially related memory issue with a larger base64 string generated from a file
- ran in a node 8 docker container against the db2 container
