#!/bin/bash

echo "Start init.sh in vagrant provisioning ..."

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install podman podman-compose

sudo mv ~/work/config/registries.conf /etc/containers/registries.conf
sudo chown root:root /etc/containers/registries.conf
sudo chmod 644 /etc/containers/registries.conf

echo "End init.sh in vagrant provisioning ..."
