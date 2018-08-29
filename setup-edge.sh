#!/bin/sh
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > ./microsoft-prod.list
cp ./microsoft-prod.list /etc/apt/sources.list.d/
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
apt-get update
apt-get install -y moby-engine
apt-get install -y moby-cli
# https://www.rxx0.com/software/ubuntu/debconf-unable-to-initialize-frontend-dialog-solution.html Or it will block next scripts.
apt-get install -y dialog
apt-get install -y iotedge
sed -i.bak "s|device_connection_string:.*$|device_connection_string: \"$1\"|" /etc/iotedge/config.yaml
systemctl restart iotedge
