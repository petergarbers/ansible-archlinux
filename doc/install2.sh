#!/bin/bash

echo "pacstrapping"

pacstrap /mnt base base-devel grub-efi-x86_64 efibootmgr lvm2 linux linux-firmware vim git sudo dialog wpa_supplicant iwd

echo "creating fstab"
genfstab -pU /mnt >> /mnt/etc/fstab

echo "adding ramdisk to fstab"
echo "tmpfs   /tmp    tmpfs   defaults,noatime,mode=1777  0 0" >> /mnt/etc/fstab


echo "chrooting into install"
arch-chroot /mnt /bin/bash
