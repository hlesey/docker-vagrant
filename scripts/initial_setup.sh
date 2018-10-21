#!/usr/bin/env bash

### INITIAL SETUP ###
yum -y install vim git

# remove swap
#swapoff $(cat /etc/fstab | grep swap | cut -d ' ' -f1)
#sed -e '/swap/ s/^#*/#/' -i /etc/fstab

setenforce 0
sed 's/SELINUX=enforcing/SELINUX=permissive/g' -i /etc/selinux/config

### INSTALL DOCKER ###
#yum install -y docker

#systemctl enable docker && systemctl start docker
