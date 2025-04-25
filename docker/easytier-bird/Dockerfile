FROM easytier/easytier:latest AS dumper

FROM alpine:latest

RUN apk upgrade --no-cache && \
    apk add --no-cache bash tzdata ca-certificates \
    curl bind-tools iproute2 iperf3 iptables nftables \
    jq bird supervisor && \
    mkdir -p /etc/bird

COPY --from=dumper /usr/local/bin/* /usr/local/bin
COPY service.ini /etc/supervisor.d/
COPY entrypoint.sh /usr/local/bin/
COPY birdh /usr/local/bin/
COPY bird.tmpl.conf /root/

ENV BIRD_STATIC_IPV4_ENABLED=1 BIRD_STATIC_IPV6_ENABLED=1
ENV BIRD_OSPF_V2_ENABLED=1 BIRD_OSPF_V3_ENABLED=1

ENTRYPOINT ["entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
