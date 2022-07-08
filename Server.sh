## Create the necessary directories and permissions
sudo mkdir /backup
sudo mkdir /docker
sudo mkdir /downloads
sudo mkdir /storage
sudo chown -R tomo:tomo /backup
sudo chown -R tomo:tomo /docker
sudo chown -R tomo:tomo /downloads
sudo chown -R tomo:tomo /storage
sudo chmod -R 777 /backup
sudo chmod -R 777 /docker
sudo chmod -R 777 /downloads
sudo chmod -R 777 /storage

## Add Ramdisk to fstab
sudo mkdir /tmp/ramdisk
sudo chmod 777 /tmp/ramdisk
ramdisk  /tmp/ramdisk  tmpfs  defaults,size=10G,x-gvfs-show  0  0

## Install Openssh-server
sudo apt update
sudo apt upgrade
sudo apt install openssh-server
## Install Docker and Docker-Compose
sudo apt install openssh-server docker docker-compose
sudo usermod -aG docker tomo
## Install Gnome Tweaks
sudo apt install gnome-tweak-tool
## Install systemd-timesyncd
sudo apt install systemd-timesyncd
## Install flatpak
sudo apt install flatpak
## Add Flatpak repository
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
## Install Chrome (Flatpak)
sudo flatpak install flathub com.google.Chrome
## Install VS Code (Flatpak)
sudo flatpak install flathub com.visualstudio.code
## Install Steam (Flatpak)
sudo flatpak install flathub com.valvesoftware.Steam
## If missing libc.so.3 32bit library
sudo apt install libc6-i386

## Install Nvidia drivers
deb http://deb.debian.org/debian/ bullseye main contrib non-free
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list
sudo add-apt-repository contrib
sudo apt update && sudo apt upgrade -y
sudo apt install cuda nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64 cuda
sudo reboot
nvidia-smi

## Install nvidia patch for unlimited number of streams
git clone https://github.com/keylase/nvidia-patch.git
cd nvidia-patch
sudo bash ./patch.sh
sudo bash ./patch-fbc.sh

## Install nvidia docker
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)       && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg       && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list |             sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |             sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
sudo apt install nvidia-docker2
sudo systemctl restart docker
sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi
