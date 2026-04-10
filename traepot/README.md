# traepot

A simple traefik based reverse proxy for docker.

## Install

Edit `/etc/systemd/resolved.conf`

```toml
[Resolve]
DNSStubListener=yes
DNS=172.18.1.253
Domains=~pot
```

Prepare configuration directory `mkdir /etc/traepot`

Prepare coredns configuration file `cp ./etc/Corefile /etc/traepot/Corefile`

Make sure stub listener is working `ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf`
