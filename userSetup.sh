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

flatpak install -y com.heroicgameslauncher.hgl net.supertuxkart.SuperTuxKart com.usebottles.bottles com.valvesoftware.Steam net.lutris.Lutris -y
flatpak install -y com.unity.UnityHub com.obsproject.Studio
flatpak install -y com.visualstudio.code io.github.arunsivaramanneo.GPUViewer md.obsidian.Obsidian org.gnome.Boxes org.gnome.Boxes.Extension.OsinfoDb
flatpak install -y org.DolphinEmu.dolphin-emu org.openttd.OpenTTD app.xemu.xemu org.prismlauncher.PrismLauncher org.zdoom.GZDoom
flatpak install -y org.inkscape.Inkscape fr.handbrake.ghb org.gimp.GIMP org.kde.krita
flatpak install -y org.libreoffice.LibreOffice org.mozilla.firefox org.videolan.VLC
flaptak install -y xyz.armcord.ArmCord com.spotify.Client io.bassi.Amberol
exit