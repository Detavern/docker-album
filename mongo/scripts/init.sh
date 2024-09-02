#!/bin/bash

if which mongosh > /dev/null 2>&1; then
  mongo_init_bin='mongosh'
else
  mongo_init_bin='mongo'
fi

"${mongo_init_bin}" << EOF
use ${MONGO_INITDB_DATABASE}
db.auth("${MONGO_INITDB_ROOT_USERNAME}", "${MONGO_INITDB_ROOT_PASSWORD}")
db.createUser({
  user: "${INIT_SCRIPT_USERNAME}",
  pwd: "${INIT_SCRIPT_PASSWORD}",
  roles: [
    { db: "${INIT_SCRIPT_DATABASE}", role: "dbOwner" },
  ]
})
EOF
