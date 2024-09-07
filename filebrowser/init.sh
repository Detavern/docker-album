# init config db
docker run --rm -v /data/filebrowser/config:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db config init
docker run --rm -v /data/filebrowser/config:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db config set -a 0.0.0.0 -p 80 -b $BASE_URL
docker run --rm -v /data/filebrowser/config:/tmp filebrowser/filebrowser \
    -d /tmp/filebrowser.db users add admin $PASSWORD --perm.admin
