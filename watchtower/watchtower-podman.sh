podman run -d --name watchtower -h watchtower \
  --restart=unless-stopped \
  --tz=UTC \
  -v /var/run/podman/podman.sock:/var/run/docker.sock \
  m.daocloud.io/docker.io/containrrr/watchtower:latest \
  --schedule "0 0 20 * * 0" \
  --cleanup \
  --label-enable
