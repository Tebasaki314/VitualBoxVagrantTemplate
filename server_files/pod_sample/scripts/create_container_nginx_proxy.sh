#!/bin/bash

# Create directories for nginx configuration files
# mkdir -p ${HOST_DIR}/conf.d

# Create a Podman container for nginx and attach it to the public network
podman run -d \
    --name ${NGINX_CONTAINER_NAME} \
    --network ${PUBLIC_NETWORK_NAME} \
    -p 80:80 \
    -p 443:443 \
    -v ${NGINX_HOST_DIR}/nginx.conf:${NGINX_CONTAINER_CONF_DIR}/nginx.conf:ro \
    -v ${NGINX_HOST_DIR}/conf.d:${NGINX_CONTAINER_CONF_DIR}/conf.d:ro \
    ${NGINX_IMAGE_NAME}

# Connect the container to the private network
podman network connect ${PRIVATE_NETWORK_NAME} ${NGINX_CONTAINER_NAME}

# Check if the container is running
if podman ps | grep -q ${NGINX_CONTAINER_NAME}; then
    echo "Nginx proxy container is running and attached to the '${PUBLIC_NETWORK_NAME}' and '${PRIVATE_NETWORK_NAME}' networks."
else
    echo "Failed to start the Nginx proxy container."
fi
