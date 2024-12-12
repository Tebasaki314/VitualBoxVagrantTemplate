#!/bin/bash

echo "[Start] Creating a mail_pod."

# Get the absolute directory of the script
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Load environment variables from .env file
set -o allexport
source "${SCRIPT_DIR}/.env"
set -o allexport

if podman pod ls | grep -q $MAIL_POD_NAME; then
    echo "Pod '$MAIL_POD_NAME' is already created."
else
    # Create a new Pod using the variables
    podman pod create \
        --name $MAIL_POD_NAME \
        --net $PUBLIC_NETWORK_NAME,$PRIVATE_NETWORK_NAME \
        -p 25:25 \
        -p 465:465 \
        -p 587:587 \
        -p 993:993


    # Verify the Pod creation
    if [ $? -eq 0 ]; then
        echo "Pod '$MAIL_POD_NAME' created and connected to '$PUBLIC_NETWORK_NAME', '$PRIVATE_NETWORK_NAME' successfully."
    else
        echo "Failed to create and connect Pod '$MAIL_POD_NAME' to networks."
        exit 1
    fi
fi

# ${SCRIPT_DIR}/containers/create_container_docker_mailserver.sh

echo "[End] Creating a mail_pod."
