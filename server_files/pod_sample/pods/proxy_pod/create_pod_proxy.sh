#!/bin/bash

echo "[Start] Creating a proxy_pod"

# Get the absolute directory of the script
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Create a new Pod using the variables
podman pod create \
    --name $PROXY_POD_NAME \
    --net $PUBLIC_NETWORK_NAME,$PRIVATE_NETWORK_NAME \
    -p 80:80 \
    -p 443:443 \

# Verify the Pod creation
if [ $? -eq 0 ]; then
    echo "Pod '$PROXY_POD_NAME' created and connected to '$PUBLIC_NETWORK_NAME' and '$PRIVATE_NETWORK_NAME' successfully."
else
    echo "Failed to create and connect Pod '$PROXY_POD_NAME' to networks."
    exit 1
fi

${SCRIPT_DIR}/containers/create_container_nginx_proxy.sh

echo "[End] Creating a proxy_pod."
