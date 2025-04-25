#!/bin/bash

set -euo pipefail

# first run
FIRST_RUN="/root/.firstrun"
BIRD_CONF_DIR="/etc/bird"
BIRD_CONF_FILE="${BIRD_CONF_DIR}/bird.conf"

comment_block_after_header() {
    local header="$1"
    local file="$2"
    local temp_file=$(mktemp)

    awk -v header="$header" '
        $0 ~ "^"header {print; in_block=1; next}
        in_block && /^$/ {in_block=0}
        in_block && !/^# / {sub(/^/, "# ")}
        {print}
    ' "$file" > "$temp_file" && mv "$temp_file" "$file"
}

if [ ! -f "${FIRST_RUN}" ]; then
    # check env
    if [ -z "${EASYTIER_CONFIG_SERVER}" ]; then
        echo "EASYTIER_CONFIG_SERVER not set, check it manually" 2>&1
        exit 1
    fi

    # init bird.conf
    if [ ! -f "${BIRD_CONF_FILE}" ]; then
        cp /root/bird.tmpl.conf ${BIRD_CONF_FILE}

        # router id
        sed -i "s/^\(router id\) .*\?;/\1 ${BIRD_ROUTER_ID};/" ${BIRD_CONF_FILE}

        # static ipv4
        if [ "${BIRD_STATIC_IPV6_ENABLED}" = "0" ]; then
            comment_block_after_header "### static ipv4" ${BIRD_CONF_FILE}
        fi

        # static ipv6
        if [ "${BIRD_STATIC_IPV4_ENABLED}" = "0" ]; then
            comment_block_after_header "### static ipv6" ${BIRD_CONF_FILE}
        fi

        # ospf v2
        if [ "${BIRD_OSPF_V2_ENABLED}" = "0" ]; then
            comment_block_after_header "### ospf v2" ${BIRD_CONF_FILE}
        fi

        # ospf v3
        if [ "${BIRD_OSPF_V3_ENABLED}" = "0" ]; then
            comment_block_after_header "### ospf v3" ${BIRD_CONF_FILE}
        fi
    fi

    # prepare static directory
    BIRD_CONF_STATIC4_DIR="${BIRD_CONF_DIR}/static4"
    mkdir -p ${BIRD_CONF_STATIC4_DIR}
    BIRD_CONF_STATIC6_DIR="${BIRD_CONF_DIR}/static6"
    mkdir -p ${BIRD_CONF_STATIC6_DIR}

    # add cron
    echo -e "0\t17\t*\t*\t*\tbirdh load" >> /etc/crontabs/root

    # write
    touch ${FIRST_RUN}
fi

exec "$@"
