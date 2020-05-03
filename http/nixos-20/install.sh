#!/bin/sh -eux

# Partition disk
cat <<FDISK | fdisk /dev/vda
n




a
w

FDISK

# Create filesystem
mkfs.ext4 -j -L nixos /dev/vda1

# Mount filesystem
mount LABEL=nixos /mnt

# Setup system
nixos-generate-config --root /mnt

mv -v hardware-builder.nix /mnt/etc/nixos/hardware-builder.nix
mv -v configuration.nix /mnt/etc/nixos/configuration.nix

### Install ###
nixos-install --no-root-passwd

### Reboot ###
reboot
