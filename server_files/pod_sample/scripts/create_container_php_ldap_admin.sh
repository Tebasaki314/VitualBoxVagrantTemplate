#!/bin/bash

# Run the container
podman run -d \
    --name $PHPLDAPADMIN_CONTAINER_NAME \
    --network $PRIVATE_NETWORK_NAME \
    -e PHPLDAPADMIN_LDAP_HOSTS=$PHPLDAPADMIN_LDAP_HOSTS \
    -e PHPLDAPADMIN_HTTPS=$PHPLDAPADMIN_HTTPS \
    $PHPLDAPADMIN_IMAGE_NAME

if podman ps | grep -q ${PHPLDAPADMIN_CONTAINER_NAME}; then
    echo "Container $PHPLDAPADMIN_CONTAINER_NAME created and attached to $PRIVATE_NETWORK_NAME."
else
    echo "Failed to create container $PHPLDAPADMIN_CONTAINER_NAME."
fi
