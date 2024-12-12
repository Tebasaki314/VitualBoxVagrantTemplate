#!/bin/bash

echo "[Start] Creating container $DOCKER_MAILSERVER_CONTAINER_NAME"

if podman ps | grep -q $DOCKER_MAILSERVER_CONTAINER_NAME; then
    echo "Container $DOCKER_MAILSERVER_CONTAINER_NAME is already running."
else
    # Run the container
    podman run -d \
        --pod ${MAIL_POD_NAME} \
        --name $DOCKER_MAILSERVER_CONTAINER_NAME \
        -e OVERRIDE_HOSTNAME=${DOCKER_MAILSERVER_HOSTNAME} \
        -v ${DOCKER_MAILSERVER_HOST_MAIL_DATA_DIR}:${DOCKER_MAILSERVER_CONTAINER_MAIL_DATA_DIR} \
        -v ${DOCKER_MAILSERVER_HOST_MAIL_STATE_DIR}:${DOCKER_MAILSERVER_CONTAINER_MAIL_STATE_DIR} \
        -v ${DOCKER_MAILSERVER_HOST_MAIL_CONFIG_DIR}:${DOCKER_MAILSERVER_CONTAINER_MAIL_CONFIG_DIR} \
        -v ${DOCKER_MAILSERVER_LOCALTIME_DIR}:${DOCKER_MAILSERVER_LOCALTIME_DIR}:ro \
        -v ${DOCKER_MAILSERVER_HOST_CUSTOM_CERTS_DIR}:${DOCKER_MAILSERVER_CONTAINER_CUSTOM_CERTS_DIR}:ro \
        -e ACCOUNT_PROVISIONER=${DOCKER_MAILSERVER_ACCOUNT_PROVISIONER} \
        -e LDAP_SERVER_HOST=${DOCKER_MAILSERVER_LDAP_SERVER_HOST} \
        -e LDAP_SEARCH_BASE=${DOCKER_MAILSERVER_LDAP_SEARCH_BASE} \
        -e LDAP_BIND_DN=${DOCKER_MAILSERVER_LDAP_BIND_DN} \
        -e LDAP_BIND_PW=${DOCKER_MAILSERVER_LDAP_BIND_PW} \
        -e LDAP_QUERY_FILTER_USER="${DOCKER_MAILSERVER_LDAP_QUERY_FILTER_USER}" \
        -e LDAP_QUERY_FILTER_GROUP="${DOCKER_MAILSERVER_LDAP_QUERY_FILTER_GROUP}" \
        -e LDAP_QUERY_FILTER_ALIAS="${DOCKER_MAILSERVER_LDAP_QUERY_FILTER_ALIAS}" \
        -e LDAP_QUERY_FILTER_DOMAIN="${DOCKER_MAILSERVER_LDAP_QUERY_FILTER_DOMAIN}" \
        -e DOVECOT_PASS_FILTER="${DOCKER_MAILSERVER_DOVECOT_PASS_FILTER}" \
        -e DOVECOT_USER_FILTER="${DOCKER_MAILSERVER_DOVECOT_USER_FILTER}" \
        -e ENABLE_SASLAUTHD=${DOCKER_MAILSERVER_ENABLE_SASLAUTHD} \
        -e SASLAUTHD_MECHANISMS=${DOCKER_MAILSERVER_SASLAUTHD_MECHANISMS} \
        -e SASLAUTHD_LDAP_SERVER=${DOCKER_MAILSERVER_SASLAUTHD_LDAP_SERVER} \
        -e SASLAUTHD_LDAP_BIND_DN=${DOCKER_MAILSERVER_SASLAUTHD_LDAP_BIND_DN} \
        -e SASLAUTHD_LDAP_PASSWORD=${DOCKER_MAILSERVER_SASLAUTHD_LDAP_PASSWORD} \
        -e SASLAUTHD_LDAP_SEARCH_BASE=${DOCKER_MAILSERVER_SASLAUTHD_LDAP_SEARCH_BASE} \
        -e SASLAUTHD_LDAP_FILTER="${DOCKER_MAILSERVER_SASLAUTHD_LDAP_FILTER}" \
        -e POSTMASTER_ADDRESS=${DOCKER_MAILSERVER_POSTMASTER_ADDRESS} \
        -e SSL_TYPE=${DOCKER_MAILSERVER_SSL_TYPE} \
        -e SSL_CERT_PATH=${DOCKER_MAILSERVER_SSL_CERT_PATH} \
        -e SSL_KEY_PATH=${DOCKER_MAILSERVER_SSL_KEY_PATH} \
        -e ENABLE_RSPAMD=${DOCKER_MAILSERVER_ENABLE_RSPAMD} \
        -e ENABLE_CLAMAV=${DOCKER_MAILSERVER_ENABLE_CLAMAV} \
        -e ENABLE_FAIL2BAN=${DOCKER_MAILSERVER_ENABLE_FAIL2BAN} \
        -e DOMAINNAME=mail.dev.local \
        --cap-add ${DOCKER_MAILSERVER_CAPABILITIES} \
        --restart always \
        --privileged \
        $DOCKER_MAILSERVER_IMAGE_NAME

    if podman ps | grep -q ${DOCKER_MAILSERVER_CONTAINER_NAME}; then
        echo "Container $DOCKER_MAILSERVER_CONTAINER_NAME created and attached to $PRIVATE_NETWORK_NAME."
    else
        echo "Failed to create container $DOCKER_MAILSERVER_CONTAINER_NAME."
    fi
fi

echo "[End] Creating container $DOCKER_MAILSERVER_CONTAINER_NAME"
