# traepot

A simple traefik based reverse proxy for docker.

## Install

Edit `/etc/systemd/resolved.conf`

```toml
[Resolve]
DNS=172.18.1.3
Domains=~pot
```
