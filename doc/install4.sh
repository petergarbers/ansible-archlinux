#!/bin/bash

echo GRUB_ENABLE_CRYPTODISK=y >> /etc/default/grub

echo GRUB_CMDLINE_LINUX="cryptdevice=UUID=$(blkid /dev/nvme0n1p3 -s UUID -o value):vg0 root=/dev/mapper/vg0-root resume=/dev/mapper/vg0-swap" >> /etc/default/grub

echo "install ucode"
pacman -S intel-ucode

echo "grup install"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
grub-mkconfig -o /boot/grub/grub.cfg


echo "add users"

useradd -m -g users -G wheel peter
passwd peter

echo "add wheel in sudoers"

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
