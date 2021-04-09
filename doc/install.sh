#!/bin/bash

echo "hi world"

timedatectl set-ntp true

mkfs.fat -F32 -n EFI /dev/nvme0n1p1
mkfs.ext2 -L boot /dev/nvme0n1p2
cryptsetup --use-random luksFormat /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 luks

echo "creating lvm volumes"

pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate --size 38G vg0 --name swap
lvcreate -l +50%FREE vg0 --name root
lvcreate -l +100%FREE vg0 --name home

mkfs.ext4 /dev/mapper/vg0-root
mkfs.ext4 /dev/mapper/vg0-home
mkswap /dev/mapper/vg0-swap

echo "mounting volumes"
mount /dev/mapper/vg0-root /mnt
mkdir /mnt/home
mount /dev/mapper/vg0-home /mnt/home
mount /dev/nvme0n1p2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
echo "activate swap"
swapon /dev/mapper/vg0-swap

echo "lsblk"
lsblk
