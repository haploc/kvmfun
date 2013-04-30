#!/bin/sh
#
# A script to install CentOS 6.4 in a KVM guest
# using automatic installation from installable distribution
# image on an HTTP server

# Defined MAC range 52:54:00:8E:FF:00 - 52:54:00:8E:FF:FF
# Choose the last number to your own preference
 
if [ $# -ne 1 ]
then
echo "Usage: $0 guest-name"
exit 1
fi

size=8
CPUs=2
RAM=1024
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
-l http://centos.cu.be/6.4/os/x86_64/ \
--os-type linux \
--os-variant rhel6 \
--noautoconsole \
--nographics \
--hvm \
--network bridge=br0,mac=${VMMAC} \
--extra-args="ks=${wwwhost}/centos6-cis-benchmarks.ks ksdevice=eth0 text console=tty1 console=ttyS0,115200"
