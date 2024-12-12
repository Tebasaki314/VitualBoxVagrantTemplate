#!/bin/bash

echo "[Start] Creating container mail_ldap"

if podman ps | grep -q mail_ldap; then
    echo "Container mail_ldap is already running."
else
    podman build -t mail_ldap_image ./mail_ldap
    # Run the container
    podman run -d \
        --pod mail_pod \
        --name mail_ldap \
        -v /server_files/pod_sample/pods/mail_pod/containers/mail_ldap/etc/postfix/main.cf:/etc/postfix/main.cf \
        -v /server_files/pod_sample/pods/mail_pod/containers/mail_ldap/etc/postfix/master.cf:/etc/postfix/master.cf \
        -v /server_files/pod_sample/pods/mail_pod/containers/mail_ldap/etc/postfix/ldap:/etc/postfix/ldap \
        -v /server_files/pod_sample/pods/mail_pod/containers/mail_ldap/etc/postfix/tls:/etc/postfix/tls \
        --cap-add "NET_ADMIN" \
        --restart always \
        mail_ldap_image

    if podman ps | grep -q mail_ldap; then
        echo "Container mail_ldap created."
    else
        echo "Failed to create container mail_ldap."
    fi
fi

echo "[End] Creating container mail_ldap"
