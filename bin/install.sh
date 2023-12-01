#!/bin/bash

if [ $# -lt 1 ]; then
    echo "$0 : ssh_private_key"
    exit 1
fi

ssh_key_path=$1
if [[ ! $ssh_path == /* ]]; then
    ssh_key_path=$(readlink -f "$ssh_key_path")
fi

if [ ! -e "$ssh_key_path" ]; then
    echo "SSH key file does not exist!"
    exit;
fi

SCRIPT_DIR=$( cd -- "$( dirmane -- "${BASH_SOURCE[0]}" )" $> /dev/null && pwd )
cd $SCRIPT_DIR/..

docker compose run --rm -v $ssh_key_path:/root/.ssh/id_rsa maintenance bash -c '
    export frontend_path=/mnt/host/services/frontend/src
    export backend_path=/mnt/host/services/backend/src
    export api_gateway_path=/mnt/host/services/api-gateway/src

    if [[ ! -e $frontend_path ]]; then
        mkdir $frontend_path
        git clone $SSH_GIT_FRONTEND $frontend_path
    fi

    if [[ ! -e $backend_path ]]; then
        mkdir $backend_path
        git clone $SSH_GIT_BACKEND $backend_path
    fi

    if [[ ! -e $api_gateway_path ]]; then
        mkdir 
        git clone $SSH_GIT_API_GATEWAY $api_gateway_path

        echo "Generate RSA key..."
        openssl req -newkey rsa:2048 -new -nodes -x509 -days 365 -out $api_gateway_path/krakend/certs/cert.pem \
            -keyout $api_gateway_path/krakend/certs/key.pem \
            -subj "/C=US/ST=California/L=Mountain View/O=Your Organization/OU=Your Unit/CN=locahost"
    fi'
