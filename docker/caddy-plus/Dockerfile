# syntax=docker/dockerfile:1
# test: docker build -t caddy-plus .
FROM caddy:2.11.3-builder AS builder
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/tencentcloud \
    --with github.com/mholt/caddy-l4

# @version
FROM caddy:2.11.3 AS caddy
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
