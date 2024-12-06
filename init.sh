#!/bin/bash

echo "Start init.sh in vagrant provisioning ..."

echo "- Start install podman ..."

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install podman podman-compose

sudo mv ~/work/config/etc/containers/registries.conf /etc/containers/registries.conf
sudo chown root:root /etc/containers/registries.conf
sudo chmod 644 /etc/containers/registries.conf

echo "- End install podman ..."

echo "- Start install cockpit ..."

. /etc/os-release
sudo apt install -y -t ${VERSION_CODENAME}-backports cockpit cockpit-podman
sudo systemctl restart cockpit

echo "- End install cockpit ..."

echo " - Start launch podman containers for LDAP servers ..."

sudo /server_files/pod_sample/init.sh

echo " - End launch podman containers for LDAP servers ..."

echo "End init.sh in vagrant provisioning ..."
