#!/bin/bash

# Pull the latest OpenLDAP image
podman pull $LDAP_IMAGE

# Run the OpenLDAP container
podman run -d \
    --name $LDAP_CONTAINER_NAME \
    --network $PRIVATE_NETWORK_NAME \
    -e LDAP_ADMIN_PASSWORD=$LDAP_ADMIN_PASSWORD \
    -e LDAP_ORGANISATION=$LDAP_ORGANISATION \
    -e LDAP_DOMAIN=$LDAP_DOMAIN \
    $LDAP_IMAGE

# Check if the container is running
if podman ps | grep -q $LDAP_CONTAINER_NAME; then
    echo "OpenLDAP server container is running."
else
    echo "Failed to start OpenLDAP server container."
fi