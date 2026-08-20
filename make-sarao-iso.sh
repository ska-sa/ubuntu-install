#!/bin/bash

# Get default boot options
#xorriso -indev ~/Downloads/ubuntu-26.04-desktop-amd64.iso -report_el_torito as_mkisofs > ~/ubuntu-install/boot_opts.txt

# Mount and copy Ubuntu installer
sudo rm -rf /tmp/iso-orig /tmp/iso-new
mkdir -p /tmp/iso-orig /tmp/iso-new
sudo mount -o loop ~/Downloads/ubuntu-26.04-desktop-amd64.iso /tmp/iso-orig
sudo rsync -a /tmp/iso-orig/ /tmp/iso-new/
sudo umount /tmp/iso-orig

# Edit copy of installer
sudo chown -R "$USER:$USER" /tmp/iso-new
chmod +w /tmp/iso-new/boot/grub
chmod +w /tmp/iso-new/boot/grub/grub.cfg
sed -i 's#quiet splash#quiet splash autoinstall ds=nocloud-net;s=https://raw.githubusercontent.com/ska-sa/ubuntu-install/main/#' /tmp/iso-new/boot/grub/grub.cfg
sed -i 's/set timeout=[0-9]*/set timeout=3/' /tmp/iso-new/boot/grub/grub.cfg

# Create new ISO
cd /tmp/iso-new
xorriso -as mkisofs -r -V "SARAO-Ubuntu-26"  \
  --modification-date='2026082007585100' \
  --grub2-mbr --interval:local_fs:0s-15s:zero_mbrpt,zero_gpt:'/home/jan/Downloads/ubuntu-26.04-desktop-amd64.iso' \
  --protective-msdos-label \
  -partition_cyl_align off \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b --interval:local_fs:12721412d-12731707d::'/home/jan/Downloads/ubuntu-26.04-desktop-amd64.iso' \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2_start_3180353s_size_10296d:all::' \
  -no-emul-boot \
  -boot-load-size 10296 \
  -J -joliet-long \
  -o ~/ubuntu-install/sarao-ubuntu-26.iso
