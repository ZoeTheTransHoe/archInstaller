#!/bin/bash

fdisk -l 
echo -N "Which Drive Do You Want To Install Arch Linux Onto?"
read -r TARGET_DISK

echo "Go Make A Coupa Now..."
loadkeys /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz
iwctl station wlan0 connect vodafone090A70 Fm7s3fkGaeZXm63X
timedatectl set-ntp true

ls /sys/firmware/efi/efivars || { echo "Boot Type Is Not UEFI!; "exit 1; }

fdisk "${TARGET_DISK}" <<EOF
n
1

+800M
t
1

n
2

+8G
t
2
19


n
3


w
EOF

mkfs.fat -F32 "${TARGET_DISK}1"
mkswap "${TARGET_DISK}2"
mkfs.ext4 -m 1 "${TARGET_DISK}3"

mount "${TARGET_DISK}3" /mnt
mkdir -p /mnt/boot
mount "${TARGET_DISK}1" /mnt/boot
