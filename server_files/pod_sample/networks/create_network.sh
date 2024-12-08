#!/bin/bash

echo "[Start] Creating the public and private network..."

# Create public bridge network using podman with specified subnet and gateway
podman network create --driver bridge --subnet $PUBLIC_SUBNET --gateway $PUBLIC_GATEWAY $PUBLIC_NETWORK_NAME

# Verify the public network creation
if [ $? -eq 0 ]; then
    echo "Bridge network '$PUBLIC_NETWORK_NAME' created successfully with subnet '$PUBLIC_SUBNET' and gateway '$PUBLIC_GATEWAY'."
else
    echo "Failed to create bridge network '$PUBLIC_NETWORK_NAME'."
fi

# Create private bridge network using podman with specified subnet, gateway, and internal option
podman network create --driver bridge --subnet $PRIVATE_SUBNET --gateway $PRIVATE_GATEWAY --internal $PRIVATE_NETWORK_NAME

# Verify the private network creation
if [ $? -eq 0 ]; then
    echo "Internal bridge network '$PRIVATE_NETWORK_NAME' created successfully with subnet '$PRIVATE_SUBNET' and gateway '$PRIVATE_GATEWAY'."
else
    echo "Failed to create internal bridge network '$PRIVATE_NETWORK_NAME'."
fi

echo "[End] Creating the public and private network."
