FROM easytier/easytier:latest AS dumper

FROM alpine:latest

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata iproute2 ca-certificates curl bird supervisor jq && \
    mkdir -p /etc/bird

COPY --from=dumper /usr/local/bin/* /usr/local/bin
COPY service.ini /etc/supervisor.d/
COPY entrypoint.sh /usr/local/bin/
COPY bird.tmpl.conf /root/

ENTRYPOINT ["entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
