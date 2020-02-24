#!/bin/sh -eux

sfdisk /dev/vda << EOF
label: dos
, 200M, L, *
, , L,
EOF

mkfs.vfat -F32 /dev/vda1
mkfs.ext4 /dev/vda2

mount /dev/vda2 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
yes | xbps-install -Sy -R https://void.webconverger.org/current -r /mnt base-system grub sudo

mount -t proc proc /mnt/proc
mount -t sysfs sys /mnt/sys
mount -o bind /dev /mnt/dev
mount -t devpts pts /mnt/dev/pts
cp /root/install-chroot.sh /mnt/install-chroot.sh
chmod +x /mnt/install-chroot.sh
cp /etc/resolv.conf /mnt/etc/resolv.conf

chroot /mnt "/install-chroot.sh"

sync
rm /mnt/install-chroot.sh
sudo umount -R /mnt
