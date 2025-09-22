## Add user to sudoers:
su
## as root
sudo visudo
# Add [username] ALL=(ALL:ALL) ALL


## Create the necessary directories and permissions
sudo mkdir /backup
sudo mkdir /storage
sudo chown -R tomo:tomo /backup
sudo chown -R tomo:tomo /system/docker
sudo chown -R tomo:tomo /system/downloads
sudo chown -R tomo:tomo /storage
sudo chmod -R 700 /backup
sudo chmod -R 700 /system/docker
sudo chmod -R 700 /system/downloads
sudo chmod -R 700 /storage

## Link created directories to root paths
sudo ln -s /system/docker /
sudo ln -s /system/downloads /

## Add Ramdisk to fstab
sudo mkdir /tmp/ramdisk
sudo chmod 777 /tmp/ramdisk
ramdisk  /tmp/ramdisk  tmpfs  defaults,size=10G,x-gvfs-show  0  0

## Update apt
sudo apt update && sudo apt upgrade -y

## Install Docker
curl -sSL https://get.docker.com | sh
## Add user to docker group
sudo usermod -aG docker $USER

## Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale set --advertise-exit-node
sudo tailscale up --advertise-routes=192.168.2.0/24 --ssh --advertise-exit-node

## Install Openssh-server
sudo apt install openssh-server

## Install systemd-timesyncd
sudo apt install systemd-timesyncd

## Install flatpak
sudo apt install flatpak
sudo apt update
## Add Flatpak repository
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Install Avidemux (Flatpak)
flatpak install flathub org.avidemux.Avidemux
## Install Calibre (Flatpak)
flatpak install flathub com.calibre_ebook.calibre
## Install Flatseal (Flatpak)
flatpak install flathub com.github.tchx84.Flatseal
## Install MKVToolNix (Flatpak)
flatpak install flathub org.bunkus.mkvtoolnix-gui
## Install OBS Studio (Flatpak)
flatpak install flathub com.obsproject.Studio
## Install openterfaceQT (Flatpak)
flatpak install flathub com.openterface.openterfaceQT
## Install Raspberry Pi Imager (Flatpak)
flatpak install flathub org.raspberrypi.rpi-imager
## Install Plex Desktop (Flatpak)
 flatpak install flathub tv.plex.PlexDesktop
## Install Viber (Flatpak)
flatpak install flathub com.viber.Viber
## Install VLC (Flatpak)
flatpak install flathub org.videolan.VLC
