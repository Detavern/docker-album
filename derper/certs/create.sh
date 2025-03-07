#!/bin/bash

openssl req -config openssl.conf \
    -new -sha256 -x509 -days 3650 \
    -keyout derper.key -out derper.crt
