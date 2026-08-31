#!/bin/bash
set -euo pipefail

ORIGINAL_ISO="$HOME/Downloads/ubuntu-26.04.1-desktop-amd64.iso"
OUTPUT_ISO="$HOME/ubuntu-install/sarao-ubuntu-26.iso"
GRUB_CFG="/tmp/sarao-grub.cfg"
USER_DATA="$HOME/ubuntu-install/user-data"
META_DATA="$HOME/ubuntu-install/meta-data"
#SEED_URL="https://raw.githubusercontent.com/ska-sa/ubuntu-install/main/"

rm -f "$OUTPUT_ISO" "$GRUB_CFG"

# Extract the stock Ubuntu GRUB configuration.
xorriso -osirrox on \
    -indev "$ORIGINAL_ISO" \
    -extract /boot/grub/grub.cfg "$GRUB_CFG"

# Enable unattended installation from a seed baked onto the ISO itself,
# not fetched over the network. nocloud-net needs working network before
# any Wi-Fi has been joined, which never happens on Wi-Fi-only hardware —
# the fetch silently times out and Subiquity falls back to a normal
# interactive install. /cdrom is casper's mount point for whatever device
# was actually booted, USB stick included, so this works with no network
# at all at the point Subiquity looks for it.
# The \\; produces a literal \; in grub.cfg, so GRUB passes
# the semicolon to the kernel instead of treating it as a command separator.
sed -i \
    "s#--- quiet splash#autoinstall ds=nocloud\\\\;s=/cdrom/nocloud/ --- quiet splash#" \
    "$GRUB_CFG"

# Reduce the GRUB menu timeout.
sed -i \
    's/set timeout=[0-9]*/set timeout=3/' \
    "$GRUB_CFG"

# Add passwords from local secret files
WIFI_PASSWORD=$(cat ~/.sarao-wifi-pass)
ITADMIN_HASH="$(openssl passwd -6 -stdin < ~/.sarao-itadmin)"
printf '%s' "$ITADMIN_HASH" > /tmp/itadmin.hash
RENDERED_USER_DATA="/tmp/user-data-rendered"
sed "s/WIFI_PASSWORD/$WIFI_PASSWORD/" "$USER_DATA" > "$RENDERED_USER_DATA"

# Rebuild from the original ISO: swap in grub.cfg, and add the seed files.
xorriso \
    -indev "$ORIGINAL_ISO" \
    -outdev "$OUTPUT_ISO" \
    -map "$GRUB_CFG" /boot/grub/grub.cfg \
    -map "$USER_DATA" /nocloud/user-data \
    -map "$META_DATA" /nocloud/meta-data \
    -map /tmp/itadmin.hash /nocloud/itadmin.hash \
    -boot_image any replay \
    -commit

sync
echo "Created $OUTPUT_ISO"

