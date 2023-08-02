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

echo "root:1" | chpasswd -R /mnt -c NONE
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
flatpak install com.mattjakeman.ExtensionManager -y

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
pacman -S lxqt breeze-icons sddm --noconfirm
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
exit

flatpak install app.xemu.xemu \
com.discordapp.Discord\
com.github.tchx84.Flatseal\
com.heroicgameslauncher.hgl\
com.mojang.Minecraft\
com.obsproject.Studio\
com.raggesilver.BlackBox\
com.slack.Slack\
com.spotify.Client\
com.unity.UnityHub\
com.usebottles.bottles\
com.valvesoftware.Steam\
com.visualstudio.code\
fr.handbrake.ghb\
hu.kramo.Cartridges\
io.bassi.Amberol\
io.github.Figma_Linux.figma_linux\
io.github.arunsivaramanneo.GPUViewer\
io.github.shiftey.Desktop\
io.gitlab.adhami3310.Footage\
md.obsidian.Obsidian\
me.kozec.syncthingtk\
net.davidotek.pupgui2\
net.lutris.Lutris\
net.supertuxkart.SuperTuxKart\
org.DolphinEmu.dolphin-emu\
org.freedesktop.Sdk.Extension.dotnet6\
org.freedesktop.Sdk.Extension.dotnet6\
org.freedesktop.Sdk.Extension.mono5\
org.freedesktop.Sdk.Extension.mono6\
org.gimp.GIMP\
org.gnome.Boxes\
org.gnome.Boxes.Extension.OsinfoDb\
org.gnome.Builder\
org.gnome.Devhelp\
org.gnome.Epiphany\
org.gnome.Glade\
org.gnome.Loupe\
org.gnome.Loupe.HEIC\
org.gnome.Mahjongg\
org.inkscape.Inkscape\
org.kde.krita\
org.libreoffice.LibreOffice\
org.nickvision.tubeconverter\
org.openttd.OpenTTD\
org.prismlauncher.PrismLauncher\
org.videolan.VLC\
org.winehq.Wine.DLLs.dxvk\
org.winehq.Wine.gecko\
org.winehq.Wine.mono\
org.zdoom.GZDoom\
xyz.armcord.ArmCord\
-y 
