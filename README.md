# ubuntu-install for SARAO laptops

Intended for use with standard Ubuntu 26.04 installer
( https://releases.ubuntu.com/26.04/ubuntu-26.04.1-desktop-amd64.iso )


## Instructions

To create an SARAO ubuntu installer iso, you need these files in place:
```
~/.sarao-itadmin-clear # itadmin user password
~/.sarao-wifi-pass # SARA Guest wifi password
~/Downloads/ubuntu-26.04.1-desktop-amd64.iso
~/ubuntu-install/itsm_tdoSnrqk_ccsl_installer.run
```
and then run ubuntu-install/make-sarao-iso.sh

## To Do

Unattended-upgrades for chrome, mattermost zoom geteduroam and ubuntu-updates?
