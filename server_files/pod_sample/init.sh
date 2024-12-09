#!/bin/bash

# Get the absolute directory of the script
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)

# Load environment variables from .env file
set -o allexport
source "${SCRIPT_DIR}/.env"
set -o allexport

${SCRIPT_DIR}/networks/create_base_networks.sh

${SCRIPT_DIR}/pods/ldap_pod/create_pod_ldap.sh

${SCRIPT_DIR}/pods/proxy_pod/create_pod_proxy.sh
