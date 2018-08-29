#!/bin/sh
# Or it will block next scripts.
export DEBIAN_FRONTEND="noninteractive"
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > ./microsoft-prod.list
cp ./microsoft-prod.list /etc/apt/sources.list.d/
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
cp ./microsoft.gpg /etc/apt/trusted.gpg.d/
apt-get update
apt-get install -y moby-engine
apt-get install -y moby-cli
echo "TEST1" >> /home/zhqqi/test
apt-get install -y iotedge || true
echo "TEST2" >> /home/zhqqi/test
sed -i.bak "s|device_connection_string:.*$|device_connection_string: \"$1\"|" /etc/iotedge/config.yaml
echo "TEST3" >> /home/zhqqi/test
systemctl restart iotedge || true
echo "TEST4" >> /home/zhqqi/test
