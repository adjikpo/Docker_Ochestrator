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

#TODO add a dockerfile maintenance install the sshkey
