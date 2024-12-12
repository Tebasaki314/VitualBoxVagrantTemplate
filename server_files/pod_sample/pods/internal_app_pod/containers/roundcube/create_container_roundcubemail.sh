#!/bin/bash

echo "[Start] Creating container $ROUNDCUBEMAIL_CONTAINER_NAME"

if podman ps | grep -q $ROUNDCUBEMAIL_CONTAINER_NAME; then
    echo "Container $ROUNDCUBEMAIL_CONTAINER_NAME is already running."
else
    # Run the container
    podman run -d \
        --pod ${MAIL_POD_NAME} \
        --name ${ROUNDCUBEMAIL_CONTAINER_NAME} \
        -e ROUNDCUBEMAIL_DEFAULT_HOST=mail_pod \
        -e ROUNDCUBEMAIL_SMTP_SERVER=mail_pod \
        roundcube/roundcubemail

    if podman ps | grep -q ${ROUNDCUBEMAIL_CONTAINER_NAME}; then
        echo "Container $ROUNDCUBEMAIL_CONTAINER_NAME created and attached to $PRIVATE_NETWORK_NAME."
    else
        echo "Failed to create container $ROUNDCUBEMAIL_CONTAINER_NAME."
    fi
fi

echo "[End] Creating container $ROUNDCUBEMAIL_CONTAINER_NAME"
