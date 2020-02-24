#!/bin/sh -eux

useradd vagrant
echo "vagrant:vagrant" | chpasswd -c SHA512

echo "root:voidlinux" | chpasswd -c SHA512

ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default/dhcpcd
ln -s /etc/sv/sshd /etc/runit/runsvdir/default/sshd

echo "voidlinux" > /etc/hostname

echo 'HOSTNAME="voidlinux"' > /etc/rc.conf
echo 'HARDWARECLOCK="UTC"' >> /etc/rc.conf
echo 'TIMEZONE="Asia/Chongqing"' >> /etc/rc.conf
echo 'KEYMAP="us"' >> /etc/rc.conf
echo "/dev/vda1	 /boot	vfat	defaults	0	2" >> /etc/fstab
echo "/dev/vda2	 /	 ext4	defaults	0	1" >> /etc/fstab

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

echo 'hostonly="yes"' >> /etc/dracut.conf

grub-install /dev/vda

#linux_kernel=`xbps-query --regex -Rs '^linux[[:digit:]]\.[-0-9\._]*$' | cut -f2 -d' ' | sort -V | tail -n1`

#xbps-reconfigure -f ${linux_kernel}
