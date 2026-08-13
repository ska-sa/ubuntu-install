# ubuntu-install for SARAO laptops

Customizations for Ubuntu install. Intended for use with standard
Ubuntu installer, aiming at supporting 24.04 and 26.04.

## Instructions

When the GRUB menu appears in the QEMU window:

1. Highlight "Try or Install Ubuntu", press **`e`** to edit.
2. Find the `linux /casper/vmlinuz ...` line and append:
   ```
   autoinstall ds=nocloud-net;s=https://raw.githubusercontent.com/YOUR-GH-USER/ubuntu-sarao/main/
   ```
3. Press **Ctrl+X** (or F10) to boot with that one-off edit.


git add .
git commit -m "minimal autoinstall test: one package + wallpaper"
git branch -M main
git remote add origin git@github.com:YOUR-GH-USER/ubuntu-sarao.git
git push -u origin main
ust more files and more `late-commands` lines.
