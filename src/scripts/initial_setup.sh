#!/usr/bin/env bash
set -xe

# install basic tools
apt-get update 
apt-get install -y vim git net-tools telnet psmisc lsof

# supress console warnings
cat <<EOF > /etc/environment
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
EOF

# configure external DNS, instead of using VBox DNS
# systemd-resolve --status
echo "DNS=8.8.8.8" >> /etc/systemd/resolved.conf
echo "DNS=8.8.4.4" >> /etc/systemd/resolved.conf
systemctl restart systemd-resolved
