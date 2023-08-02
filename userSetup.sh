#!/bin/bash

# set settings related to locale
sed -i -e 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# set the time zone
echo -n "Enter Time Zone: " 
read -r TIME_ZONE 
ln -sf /usr/share/zoneinfo/UTC /etc/localtime 
hwclock --systohc

echo "root:1" | chpasswd -R /mnt
echo "zoey:1" | chpasswd -R /mnt
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
# install and configure grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# enable NetworkManager systemd service
systemctl enable NetworkManager
systemctl enable iwd

pacman -S htop flatpak hyfetch bash-completion --noconfirm 

if [[ "$1" == GNOME ]];
then
echo "Installing GNOME"
pacman -S gnome --noconfirm 
systemctl enable gdm

elif [[ "$1" == KDE ]];
then
echo "Installing KDE"
pacman -S plasma plasma-wayland-session --noconfirm 
systemctl enable sddm

elif [[ "$1" == XFCE ]];
then
echo "Installing XFCE"
pacman -S xfce4 xfce4-goodies --noconfirm

elif [ -z "$1" ];
then
echo "Nothing Selected - Installing GNOME"

else
echo "That Is Not A Valid DE"
fi


