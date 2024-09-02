db.auth("${MONGO_INITDB_ROOT_USERNAME}", "${MONGO_INITDB_ROOT_PASSWORD}")
db.createUser({
  user: "${INIT_SCRIPT_USERNAME}",
  pwd: "${INIT_SCRIPT_PASSWORD}",
  roles: [
    { db: "${INIT_SCRIPT_DATABASE}", role: "dbOwner" },
  ]
})
