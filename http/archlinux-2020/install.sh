#!/bin/sh -eux

device=/dev/vda
export device

sfdisk "$device" <<EOF
label: dos
size=1000000KiB, type=82
                 type=83, bootable
EOF
mkswap "${device}1"
mkfs.ext4 "${device}2"
mount "${device}2" /mnt

curl -fsS https://www.archlinux.org/mirrorlist/?country=CN > /tmp/mirrolist
grep '^#Server' /tmp/mirrolist | sort -R | head -n 50 | sed 's/^#//' > /tmp/mirrolist.50
cat /tmp/mirrolist.50 | tee /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-firmware grub openssh sudo dhcpcd

swapon "${device}1"
genfstab -p /mnt >> /mnt/etc/fstab
swapoff "${device}1"

arch-chroot /mnt /bin/bash
