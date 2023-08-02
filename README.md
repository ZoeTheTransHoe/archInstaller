Arch Install Script

- Installs My Most Used Apps From Flathub 
- Choice Of GNOME/KDE/XFCE, with GNOME Being Default
- Detects If Windows Is Installed + Dual Boots Accordingly If So/Overwrites Windows If User 	Requests It. By Default Will Dual Boot With Max Space Given To Arch 

To Install : 
Boot Into Arch ISO, Connect To Wifi/Ethernet/Cellular. 
Run 

`curl -LJO https://github.com/ZoeTheTransHoe/archInstaller/releases/download/[Latest_Release]/archInstaller.tar.xz`

Where [Latest_Release] is the version number of the latest release etc v1.0.5. Then:

`tar -xf archInstaller.tar.xz`

`cd archInstaller`

`chmod +x ./archInstaller.sh ./userSetup.sh`

`./archInstaller.sh [Option Of DE]`

The Options For DE Are
- GNOME
- KDE
- XFCE
- LXQT
They must be in all caps. The Default Is GNOME.

To Do: 
- Make A Normal User 
- Setup Sudo For User
- Detect Windows Partition + Act Accordingly

