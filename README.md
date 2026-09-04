# ubuntu-install for SARAO laptops

Intended for use with standard Ubuntu 26.04.1 installer
( https://releases.ubuntu.com/26.04/ubuntu-26.04.1-desktop-amd64.iso )

This installer does a full-disk install wiping any existing OS:

* Adds packages cups, curl, dconf-cli, git, gh, vim
* Adds third-party zoom, mattermost, google-chrome
* Installs xcitium, does not link to user profile
* Save SARAO Guest Wifi and password, install geteduroam and eduvpn apps
* Add Cape Town Office printers (6)
* Hidden itadmin user and password
* Set default user wallpaper to meerkat-sky.jpg

## Instructions

To create an SARAO ubuntu installer iso, you need these files in place:
```
~/.sarao-itadmin-clear # cleartext itadmin user password
~/.sarao-wifi-pass # cleartext SARAO Guest wifi password
~/Downloads/ubuntu-26.04.1-desktop-amd64.iso
~/ubuntu-install/itsm_tdoSnrqk_ccsl_installer.run # Linux bulk installer
```
and then run `~/ubuntu-install/make-sarao-iso.sh`

## Considerations:

* Unattended upgrades for zoom, mattermost, chrome, and -updates
* Add forticlient app
* Add desktop shortcuts (geteduroam, eduvpn, eduvpn config, instructions, other aps, windows shares, dns completion)
* Docker and unattended-upgrades
* Coding environments, AI integration?

