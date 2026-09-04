# ubuntu-install for SARAO laptops


## WARNING

This installer performs a fully automated full-disk install from a USB EFI boot, wiping any existing OS! If you boot a laptop to it and walk away, it will wipe the disk without waiting for confirmation.

## What it does non-interactively from boot

* GRUB automatically boots to Try or Install Ubuntu after 3 seconds
* Installer autostarts
* Automated full-disk install of Ubuntu Desktop 26.04.1
* source: ubuntu-desktop (not -full, excludes Libreoffice and Thunderbird)
* Saves SARAO Guest Wifi and password
* Adds packages cups, curl, dconf-cli, git, gh, vim
* Adds third-party zoom, mattermost, google-chrome
* Adds third-party unconfigured geteduroam and eduvpn apps
* Adds (hidden) itadmin user and password with sudo
* Installs xcitium, does not link to user profile
* Adds Cape Town Office printers (6) and Konika Minolta PPD driver file
* Sets default user wallpaper to meerkat-sky.jpg
* Reboots to Add-a-User (including sudo)

## Instructions

To create an SARAO ubuntu installer iso, you need these files in place:
```
~/.sarao-itadmin-clear # cleartext itadmin user password
~/.sarao-wifi-pass # cleartext SARAO Guest wifi password (ask V)
~/Downloads/ubuntu-26.04.1-desktop-amd64.iso
~/ubuntu-install/itsm_tdoSnrqk_ccsl_installer.run # Linux bulk installer
```
and then run `~/ubuntu-install/make-sarao-iso.sh`

## Considerations for To Do:

* Add unattended upgrades for zoom, mattermost, chrome, and -updates
* Add forticlient app
* Add SARAO/NRF wallpapers
* Add desktop shortcuts (geteduroam, eduvpn, eduvpn config, instructions, other aps, windows shares, bookmarks, dns completion)
* Add docker-cli with unattended-upgrades
* Coding environments, e.g. code, jupyter? AI integration?
* Set xcitium/comodo to CPUQuota=50% to prevent scanning slowdowns
* pdf-arranger? useful apps?
