#!/bin/bash

echo "[Start] Creating container $LDAP_CONTAINER_NAME"

if podman ps | grep -q $LDAP_CONTAINER_NAME; then
    echo "Container $LDAP_CONTAINER_NAME is already running."
else
    # Run the OpenLDAP container
    podman run -d \
        --pod ${LDAP_POD_NAME} \
        --name $LDAP_CONTAINER_NAME \
        -v ${LDAP_HOST_DIR}/:${LDAP_CONTAINER_DIR}/:ro \
        -e LDAP_ADMIN_PASSWORD=$LDAP_ADMIN_PASSWORD \
        -e LDAP_CONFIG_PASSWORD=$LDAP_CONFIG_PASSWORD \
        -e LDAP_ORGANISATION=$LDAP_ORGANISATION \
        -e LDAP_DOMAIN=$LDAP_DOMAIN \
        $LDAP_IMAGE
    
    # Check if the container is running
    if podman ps | grep -q $LDAP_CONTAINER_NAME; then
        echo "Container $LDAP_CONTAINER_NAME is running."
    else
        echo "Failed to start container $LDAP_CONTAINER_NAME."
    fi
fi

echo "[End] Creating container $LDAP_CONTAINER_NAME"
