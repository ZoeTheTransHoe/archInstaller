#!/bin/bash

fdisk -l 
echo -N "Which Drive Do You Want To Install Arch Linux Onto?"
read -r TARGET_DISK

loadkeys /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz
timedatectl set-ntp true

ls /sys/firmware/efi/efivars || { echo "Boot Type Is Not UEFI!; "exit 1; }
sfdisk --delete $TARGET_DISK

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

echo "Go Make A Coupa Now And Wait For The Script To Be Done And Reboot The PC..."

mkfs.fat -F32 "${TARGET_DISK}1"
mkswap "${TARGET_DISK}2"
mkfs.ext4 -m 1 "${TARGET_DISK}3"

mount "${TARGET_DISK}3" /mnt
mkdir -p /mnt/boot
mount "${TARGET_DISK}1" /mnt/boot

pacstrap -K /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware vim git iwd networkmanager nano grub os-prober efibootmgr
genfstab -U /mnt >>/mnt/etc/fstab

cp userSetup.sh /mnt
arch-chroot /mnt ./userSetup.sh $1
exit
reboot
