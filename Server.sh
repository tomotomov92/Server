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
echo 'ramdisk  /tmp/ramdisk  tmpfs  defaults,size=10G,x-gvfs-show  0  0' | sudo tee -a /etc/fstab

## Update apt
sudo apt update && sudo apt upgrade -y

## Install Docker
curl -sSL https://get.docker.com | sh
## Add user to docker group
sudo usermod -aG docker $USER

## Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
cd /etc/sysctl.d
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf
sudo tailscale set --advertise-exit-node
sudo tailscale up --advertise-exit-node --advertise-routes=192.168.2.0/24,192.168.1.0/24 --ssh

## Install Openssh-server
sudo apt install openssh-server

## Install systemd-timesyncd
sudo apt install systemd-timesyncd
