#!/bin/bash

# unifi app needs 2 db
mongosh << EOF
use ${MONGO_INITDB_DATABASE}
db.auth("${MONGO_INITDB_ROOT_USERNAME}", "${MONGO_INITDB_ROOT_PASSWORD}")
db.createUser({
  user: "${INIT_SCRIPT_USERNAME}",
  pwd: "${INIT_SCRIPT_PASSWORD}",
  roles: [
    { db: "${INIT_SCRIPT_DATABASE}", role: "dbOwner" },
    { db: "${INIT_SCRIPT_DATABASE}_stat", role: "dbOwner" },
  ]
})
EOF
