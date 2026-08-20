#!/bin/bash

set -euo pipefail

ORIGINAL_ISO="$HOME/Downloads/ubuntu-26.04-desktop-amd64.iso"
OUTPUT_ISO="$HOME/ubuntu-install/sarao-ubuntu-26.iso"
GRUB_CFG="/tmp/sarao-grub.cfg"
SEED_URL="https://raw.githubusercontent.com/ska-sa/ubuntu-install/main/"

rm -f "$OUTPUT_ISO" "$GRUB_CFG"

# Extract the stock Ubuntu GRUB configuration.
xorriso -osirrox on \
    -indev "$ORIGINAL_ISO" \
    -extract /boot/grub/grub.cfg "$GRUB_CFG"

# Enable unattended installation from the NoCloud seed URL.
# The \\; produces a literal \; in grub.cfg, so GRUB passes
# the semicolon to the kernel instead of treating it as a command separator.
sed -i \
    "s#--- quiet splash#autoinstall ds=nocloud-net\\\\;s=$SEED_URL --- quiet splash#" \
    "$GRUB_CFG"

# Reduce the GRUB menu timeout.
sed -i \
    's/set timeout=[0-9]*/set timeout=3/' \
    "$GRUB_CFG"

# Rebuild from the original ISO, replacing ONLY grub.cfg.
xorriso \
    -indev "$ORIGINAL_ISO" \
    -outdev "$OUTPUT_ISO" \
    -map "$GRUB_CFG" /boot/grub/grub.cfg \
    -boot_image any replay \
    -commit

echo "Created $OUTPUT_ISO"
