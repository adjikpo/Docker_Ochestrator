#!/bin/bash

JSON_FILE="/vault/secret.json"
VAULT_ADDR="http://127.0.0.1:8200"
WAIT_INTERVAL=2

while true; do
    INIT_STATUS=$(curl -s $VAULT_ADDR/v1/sys/init)
    INITIALIZED=$(echo $INIT_STATUS | jq '.initialized')

    if [ "$INITIALIZED" = "true" ]; then
        echo "Vault is initialized."
        break
    else
        sleep $WAIT_INTERVAL
    fi
done

echo "Loading secrets....."

for SECRET_NAME in $(jq -r 'keys[]' "$JSON_FILE"); do
    SECRET_DATA=$(jq -r ".$SECRET_NAME" "$JSON_FILE")

    curl -X POST -H "X-Vault-Token: $VAULT_DEV_ROOT_TOKEN_ID" -H "Content-Type: application/json" -d "{\"data\": $SECRET_DATA}" "$VAULT_ADDR/v1/secret/data/$SECRET_NAME" &> /dev/null
done

echo "All secrets have been loaded."