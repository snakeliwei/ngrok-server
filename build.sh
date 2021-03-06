#!/bin/bash
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please specify DOMAIN"
    exit 1
fi

if [ ! -f /ngrok/bin/ngrokd ]; then
    echo "=> Compiling ngrok binary files"
    cd /ngrok
    openssl genrsa -out rootCA.key 2048
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$DOMAIN" -days 50000 -out rootCA.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=$DOMAIN" -out device.csr
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
    cp rootCA.pem assets/client/tls/ngrokroot.crt
    cp device.crt assets/server/tls/snakeoil.crt 
    cp device.key assets/server/tls/snakeoil.key
    make release-server release-client
    echo "=> Successfully built the binaries"
fi
