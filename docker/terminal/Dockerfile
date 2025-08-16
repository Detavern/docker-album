# @version
FROM debian:13.0

# apt
RUN apt-get update && \
    apt-get install -y grep locales iproute2 iputils-ping openssh-server vim python3 pwgen && \
    apt-get clean

# sshd
RUN mkdir -p /var/run/sshd && \
    mkdir -p /root/.ssh && \ 
    sed -i 's/^\(UsePAM\) .*/\1 no/' /etc/ssh/sshd_config

COPY entrypoint.sh /usr/local/bin/

ENV TZ=Asia/Hong_Kong
ENV SSH_PORT=1022
ENV ROOT_PASSWORD=
ENV ROOT_PUBKEY=
ENV ROOT_PUBKEY_DIR=/root/.ssh

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
