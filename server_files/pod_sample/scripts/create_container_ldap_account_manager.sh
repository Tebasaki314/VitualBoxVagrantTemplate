#!/bin/bash

# Pull the latest image
podman pull $LAM_IMAGE_NAME

# Create and run the container
podman run -d \
    --name $LAM_CONTAINER_NAME \
    --network $PRIVATE_NETWORK_NAME \
    -e LDAP_DOMAIN=$LDAP_DOMAIN \
    -e LDAP_BASE_DN=$LDAP_BASE_DN \
    -e LDAP_USERS_DN=$LDAP_USERS_DN \
    -e LDAP_GROUPS_DN=$LDAP_GROUP_DN \
    -e LDAP_SERVER=$LDAP_SERVER \
    -e LAM_LANGUAGE=$LAM_LANGUAGE \
    -e LAM_PASSWORD=$LAM_PASSWORD \
    -e VIRTUAL_HOST=$VIRTUAL_HOST \
    -e CERT_NAME=$CERT_NAME \
    $LAM_IMAGE_NAME

# Output the status
if [ $? -eq 0 ]; then
    echo "LDAP Account Manager container created and running on port $HOST_PORT."
else
    echo "Failed to create LDAP Account Manager container."
fi