#!/bin/bash

# set settings related to locale
sed -i -e 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# set the time zone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime 
hwclock --systohc

sudo useradd -m -G wheel zoey 
passwd zoey 

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
# install and configure grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# enable NetworkManager systemd service
systemctl enable NetworkManager
systemctl enable iwd

pacman -S yt-dlp htop flatpak hyfetch bash-completion --noconfirm 

if [[ "$1" == GNOME ]];
then
echo "Installing GNOME"
pacman -S gnome --noconfirm 
systemctl enable gdm
flatpak install com.mattjakeman.ExtensionManager org.gnome.Builder org.gnome.Epiphany org.gnome.Loupe org.gnome.Loupe.HEIC org.gnome.Mahjongg -y

elif [[ "$1" == KDE ]];
then
echo "Installing KDE"
pacman -S plasma plasma-wayland-session --noconfirm 
systemctl enable sddm

elif [[ "$1" == XFCE ]];
then
echo "Installing XFCE"
pacman -S xfce4 xfce4-goodies --noconfirm

elif [[ "$1" == LXQT ]];
then
echo "Installing LXQT"
pacman -S xorg lxqt xdg-utils ttf-freefont sddm libpulse libstatgrab libsysstat lm_sensors network-manager-applet kwin breeze-icons pavucontrol-qt --noconfirm
systemctl enable sddm

elif [ -z "$1" ];
then
echo "Nothing Selected - Installing GNOME"
pacman -S gnome --noconfirm 
systemctl enable gdm
flatpak install com.mattjakeman.ExtensionManager -y

else
echo "That Is Not A Valid DE"
fi

flatpak install -y com.heroicgameslauncher.hgl 
flatpak install -y net.supertuxkart.SuperTuxKart 
flatpak install -y com.usebottles.bottles 
flatpak install -y com.valvesoftware.Steam 
flatpak install -y net.lutris.Lutris 
flatpak install -y com.obsproject.Studio 
flatpak install -y com.unity.UnityHub 
flatpak install -y com.visualstudio.code 
flatpak install -y md.obsidian.Obsidian 
flatpak install -y org.DolphinEmu.dolphin-emu 
flatpak install -y org.openttd.OpenTTD 
flatpak install -y app.xemu.xemu 
flatpak install -y org.prismlauncher.PrismLauncher 
flatpak install -y org.zdoom.GZDoom
flatpak install -y org.inkscape.Inkscape 
flatpak install -y fr.handbrake.ghb
flatpak install -y org.gimp.GIMP 
flatpak install -y org.kde.krita
flatpak install -y org.libreoffice.LibreOffice 
flatpak install -y org.mozilla.firefox 
flatpak install -y org.videolan.VLC
flaptak install -y xyz.armcord.ArmCord 
flatpak install -y com.spotify.Client 
flatpak install -y io.bassi.Amberol
exit