# Reproducing Memory Issues

Reproducing a memory issue seen in a larger application.

Upon trying to persist some data-sets to a BLOB field within a db2 database various memory (within the binding layer) and Segmentation Faults are produced.

It isn't always the same error but it will, a majority of the time, cause the node process to abort.

## Further investigation
I've now run this against db2 in docker and an actual db2 instance
I've also ran the tests ( and thus the inserts) on linux (via docker container) and mac.

|Host OS -> DB2                   |Error Seen        |
|---------                        |-----------       |
|linux -> docker db2              |&#x2713;          |
|linux -> actual db2 instance     |&#x2713;          |
|mac -> docker db2                |&#x2717;          |
|mac -> actual db2  instance      |&#x2717;          |

The above would suggest that it's something specifically to do with running on linux as running the same inserts via mac don't exhibit the same problems.

I've added test commands to be able to run the tests against different db2 instances   
- `npm run test:...:linux` will run the tests in a docker container   
- `npm run test:...:host` will run the tests on whatever host is currently getting used

`HOST` and `PORT` of db2 you wish to run the tests against can be specified as environment variables as can be seen in the `package.json`.

Obviously this still relies on all db2 instances (docker or otherwise being set up with the same tables etc.). This can be found in `db/db2/container/provision.sql`;

# Commands

`npm run test` will
- create and start a db2 database with a single table in it with a auto generated id column and a blob field;
- run the tests within another docker container running node 8 against this db with both debug settings on (node and bindings).
- stop the db2 instance

`npm run deps:start`
- run the db2 container mentioned above

`npm run deps:stop`
- stop the db2 container mentioned above

## Issues seem to show when running on Linux

`npm run test:only:linux` - run on linux via docker container
- run the test showing memory issue with small string
- ran in a node 8 docker container against the db2 container

`npm run test:file:only:linux` - run on linux via docker container
- run the test showing potentially related memory issue with a larger base64 string generated from a file
- ran in a node 8 docker container against the db2 container

## They don't show on host machine (Mac, potentially Windows as well although I haven't had access to try)

`npm run test:only:host` - run on host machine
- run the test showing memory issue with small string - no memory issue evident
- ran in a node 8 docker container against the db2 container

`npm run test:file:only:host` - run on host machine
- run the test showing potentially related memory issue with a larger base64 string generated from a file - no memory issue evident
- ran in a node 8 docker container against the db2 container

## Vagrant
To spin up in Vagrant:

- Download IBM DB2 for Linux 64-bit to `vagrant/provision/db2/v11.1_linuxx64_dec_tar.gz`.  If the filename is different update `DB2EXPRESSC_INSTFILE` in `vagrant/provision/install-db2.sh`
- `cd vagrant`
- `vagrant up`

This will provision an Ubuntu 14.04 VM with DB2 Express C and Node 8, then copy the application files over and run the tests against the local DB2 server.