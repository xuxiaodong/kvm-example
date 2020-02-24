#!/bin/sh -eux

dnf -y remove gcc cpp gc kernel-devel kernel-headers glibc-devel elfutils-libelf-devel glibc-headers kernel-devel kernel-headers
dnf -y remove linux-firmware
dnf -y autoremove
dnf -y clean all --enablerepo=\*

find /var/log -type f -exec truncate --size=0 {} \;
find /etc/sysconfig/network-scripts -name "ifcfg-*" -not -name "ifcfg-lo" -exec rm -f {} \;

rm -f /root/anaconda-ks.cfg
rm -rf /tmp/* /var/tmp/*

truncate -s 0 /etc/machine-id
