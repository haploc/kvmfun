#!/bin/sh
#
# A script to install Debian Wheezy on a KVM guest
# using automatic installation from installable distribution
# image on an HTTP server

# Defined MAC range 52:54:00:8E:FF:00 - 52:54:00:8E:FF:FF
# Choose the last number to your own preference
 
if [ $# -ne 1 ]
then
echo "Usage: $0 guest-name"
exit 1
fi

size=2
CPUs=2
RAM=512
MyVMMACRANGE='52:54:00:8e:ff'
VMMAC=${MyVMMACRANGE}:00
wwwhost=http://example.com
 
virt-install \
--connect=qemu:///system \
--virt-type kvm \
--name=${1} \
--ram=${RAM} \
--vcpus=${CPUs} \
--disk path=/var/lib/libvirt/images/${1}.img,size=${size} \
-l http://ftp.be.debian.org/debian/dists/wheezy/main/installer-amd64/ \
--vnc \
--os-variant debianwheezy \
--noautoconsole \
--hvm \
--network bridge=br0,mac=${VMMAC} \
--extra-args="auto=true hostname=${1} domain=home url=${wwwhost}/preseed-debian_vm.txt text console=tty1 console=ttyS0,115200"
