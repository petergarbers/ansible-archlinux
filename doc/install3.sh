#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime

echo "configuring locals"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "LC_ALL=C" >> /etc/locale.conf


echo "setting hostname"

echo "doom" > /etc/hostname

passwd

echo "modify /etc/mkinitcpio.conf"
