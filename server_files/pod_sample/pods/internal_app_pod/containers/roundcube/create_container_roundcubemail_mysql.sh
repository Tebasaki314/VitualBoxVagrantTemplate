#!/bin/bash

echo "[Start] Creating container $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME"

if podman ps | grep -q $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME; then
    echo "Container $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME is already running."
else
    # Run the container
    podman run -d \
        --pod ${ROUNDCUBEMAIL_MYSQL_POD_NAME} \
        --name ${ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME} \
        -e MYSQL_ROOT_PASSWORD=${ROUNDCUBEMAIL_MYSQL_ROOT_PASSWORD} \
        -e MYSQL_DATABASE=${ROUNDCUBEMAIL_MYSQL_DATABASE} \
        ${ROUNDCUBEMAIL_MYSQL_IMAGE}

    if podman ps | grep -q ${ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME}; then
        echo "Container $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME created and attached to $PRIVATE_NETWORK_NAME."
    else
        echo "Failed to create container $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME."
    fi
fi

echo "[End] Creating container $ROUNDCUBEMAIL_MYSQL_CONTAINER_NAME"
