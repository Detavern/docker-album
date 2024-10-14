#!/bin/bash

set -eu

# first run
FIRST_RUN="/root/.terminal"
if [ ! -f "${FIRST_RUN}" ]; then
    # init tz
    ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime

    # init locale
    sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
    locale-gen
    rm /etc/ssh/ssh_host_*
    dpkg-reconfigure openssh-server || true

    # init password
    if [ -z "${ROOT_PASSWORD}" ]; then
        echo "root password not found."
        ROOT_PASSWORD=$(pwgen 22 1)
        echo "generated password is ${ROOT_PASSWORD}"
    fi
    echo "root:${ROOT_PASSWORD}" | chpasswd

    # init port
    sed -i "s/^#\?\(Port\) .*/\1 ${SSH_PORT}/" /etc/ssh/sshd_config

    # init auth key
    AUTH_FILE="/root/.ssh/authorized_keys"
    if [ ! -f "${AUTH_FILE}" ]; then
        touch "${AUTH_FILE}"
        chmod 600 "${AUTH_FILE}"
    fi

    # load pub key
    if [ -z "${ROOT_PUBKEY_DIR}" ]; then
        echo "ROOT_PUBKEY_DIR is empty, check it manually" 2>&1
        exit 1
    fi

    KEYS=$(grep -ERxh '^ssh-.*$' --include='*.pub' ${ROOT_PUBKEY_DIR} || echo "empty")
    if [[ "$KEYS" != "empty" ]]; then
        COUNT=$(echo "${KEYS}" | wc -l)
        echo "${COUNT} key(s) found"
        echo "${KEYS}" > "${AUTH_FILE}"
        sed -i 's/^#\?\(PermitRootLogin\) .*/\1 prohibit-password/' /etc/ssh/sshd_config
    elif [ -n "${ROOT_PUBKEY}" ]; then
        echo "${ROOT_PUBKEY}" > "${AUTH_FILE}"
        sed -i 's/^#\?\(PermitRootLogin\) .*/\1 prohibit-password/' /etc/ssh/sshd_config
    else
        echo "public key not found, enable password authentication"
        sed -i 's/^#\?\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config
        sed -i 's/^#\?\(PasswordAuthentication\) .*/\1 yes/' /etc/ssh/sshd_config
    fi

    # write
    echo "${ROOT_PASSWORD}" > "${FIRST_RUN}"
fi

exec "$@"
