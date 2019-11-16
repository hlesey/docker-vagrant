#!/usr/bin/env bash

### INITIAL SETUP ###
apt-get update && apt-get install -y vim git net-tools telnet psmisc lsof

# remove swap
#swapoff $(cat /etc/fstab | grep swap | cut -d ' ' -f1)
#sed -e '/swap/ s/^#*/#/' -i /etc/fstab

# supress console warnings
cat <<EOF > /etc/environment
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
EOF


### INSTALL DOCKER ###
#apt-get install -y docker-ce

#systemctl enable docker && systemctl start docker
