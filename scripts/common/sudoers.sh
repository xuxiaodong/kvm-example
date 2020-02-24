#!/bin/sh -eux

SUDO_CONF="/etc/sudoers.d/99_vagrant"

echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > "$SUDO_CONF"
chmod 440 "$SUDO_CONF"

