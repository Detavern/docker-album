#!/bin/bash

set -eu


# first run
FIRST_RUN="/root/.firstrun"
BIRD_CONF_DIR="/etc/bird"
BIRD_CONF_FILE="${BIRD_CONF_DIR}/bird.conf"
if [ ! -f "${FIRST_RUN}" ]; then
    # init bird
    if [ ! -f "${BIRD_CONF_FILE}" ]; then
        cp /root/bird.tmpl.conf ${BIRD_CONF_FILE}

        # router id
        sed -i "s/^\(router id\) .*\?;/\1 ${BIRD_ROUTER_ID};/" ${BIRD_CONF_FILE}

        # prepare ospf directory
        BIRD_CONF_OSPF_DIR="${BIRD_CONF_DIR}/ospf"
        mkdir -p ${BIRD_CONF_OSPF_DIR}

        # prepare ospf static
    fi

    # write
    touch ${FIRST_RUN}
fi


exec "$@"
