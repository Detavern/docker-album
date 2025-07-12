#!/bin/bash

# init config db
docker run --rm -v /data/filebrowser:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db config init
docker run --rm -v /data/filebrowser:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db config set -a 0.0.0.0 -p 80 -b $FILE_BROWSER_SERVER_DOMAIN \
    --recaptcha.key $RECAPTCHA_KEY --recaptcha.secret $RECAPTCHA_SECRET
docker run --rm -v /data/filebrowser:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db users add $FILE_BROWSER_ADMIN_USER $FILE_BROWSER_ADMIN_PASSWORD --perm.admin
