#!/bin/bash

echo "[Start] Creating a ldap_pod."

# Get the absolute directory of the script
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Create a new Pod using the variables
podman pod create --name $LDAP_POD_NAME --net $PRIVATE_NETWORK_NAME

# Verify the Pod creation
if [ $? -eq 0 ]; then
    echo "Pod '$LDAP_POD_NAME' created and connected to '$PRIVATE_NETWORK_NAME' successfully."
else
    echo "Failed to create and connect Pod '$LDAP_POD_NAME' to networks."
    exit 1
fi

${SCRIPT_DIR}/containers/create_container_ldap_server.sh
${SCRIPT_DIR}/containers/create_container_php_ldap_admin.sh

echo "[End] Creating a ldap_pod."