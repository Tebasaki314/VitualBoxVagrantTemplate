#!/bin/bash

# Get the absolute directory of the script
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Load environment variables from .env file
set -o allexport
source "${SCRIPT_DIR}/.env"
set -o allexport

${SCRIPT_DIR}/scripts/create_network.sh
${SCRIPT_DIR}/scripts/create_container_ldap_server.sh
${SCRIPT_DIR}/scripts/create_container_php_ldap_admin.sh
${SCRIPT_DIR}/scripts/create_container_nginx_proxy.sh
# ${SCRIPT_DIR}/scripts/create_container_ldap_account_manager.sh
# echo "Hello, World!"

# echo "The directory name of the script $(basename $0) is: $(dirname $0)"

# $(dirname "$0")/scripts/test.sh

# echo $HOST_DIR
