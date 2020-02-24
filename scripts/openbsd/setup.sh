#!/bin/sh -eux

uname_r=$(uname -r)
arch_s=$(arch -s)

export PKG_PATH
PKG_PATH="$MIRROR/pub/OpenBSD/$uname_r/packages/$arch_s/"

echo "export PKG_PATH=\"$PKG_PATH\"" >> /root/.profile
echo "export PKG_PATH=\"$PKG_PATH\"" >> /home/vagrant/.profile

pkg_add sudo--

echo "vagrant ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers

hostname=$(hostname -s)
printf "%s\n" "$hostname" > /etc/myname
printf "127.0.0.1\tlocalhost %s\n" "$hostname" > /etc/hosts
printf "::1\t\tlocalhost %s\n" "$hostname" >> /etc/hosts
