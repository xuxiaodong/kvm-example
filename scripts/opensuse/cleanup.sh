#!/bin/sh -eux

zypper clean --all

rm -f /etc/udev/rules.d/70-persistent-net.rules;
touch /etc/udev/rules.d/75-persistent-net-generator.rules;

find /var/log -type f -exec truncate --size=0 {} \;

rm -rf /tmp/* /var/tmp/*

truncate -s 0 /etc/machine-id
