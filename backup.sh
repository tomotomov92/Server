#!/bin/bash


# Create the final directory for the backups
mkdir -p /storage/Backups/$(hostname)_$(date +"%Y%m%d")


# Backup system config directories
tar -zcf /backup/system.tgz \
 --exclude=".*" \
 -c /docker/authelia \
 -c /docker/diun \
 -c /docker/dokuwiki \
 -c /docker/grafana \
 -c /docker/heimdall \
 -c /docker/influxdb \
 -c /docker/mariadb \
 -c /docker/nextcloud \
 -c /docker/pihole \
 -c /docker/portainer \
 -c /docker/redis \
 -c /docker/scrutiny \
 -c /docker/ssl_cert \
 -c /docker/swag \
 -c /docker/tailscale \
 -c /docker/vaultwarden \
 -c /docker/wireguard
 /
# Move the archive to external storage for backing up
mv /backup/system.tgz /storage/Backups/$(hostname)_$(date +"%Y%m%d")/system.tgz


# Backup downloaders config directories
tar -zcf /backup/downloaders.tgz \
 --exclude='/docker/prowlarr/logs/*' \
 -c /docker/jackett \
 -c /docker/prowlarr \
 -c /docker/transmission \
 -c /docker/youtube-dl-server
 /
# Move the archive to external storage for backing up
mv /backup/downloaders.tgz /storage/Backups/$(hostname)_$(date +"%Y%m%d")/downloaders.tgz


# Backup media config directories
sudo tar -zcf /backup/media.tgz \
 --exclude='/docker/bazarr/logs/*' \
 --exclude='/docker/overseerr/logs/*' \
 --exclude='/docker/radarr/logs/*' \
 --exclude='/docker/radarr/MediaCover/*' \
 --exclude='/docker/sonarr/logs/*' \
 --exclude='/docker/sonarr/MediaCover/*' \
 -c /docker/grafana \
 -c /docker/bazarr \
 -c /docker/overseerr \
 -c /docker/radarr \
 -c /docker/sonarr \
 -c /docker/tautulli
 /
# Move the archive to external storage for backing up
mv /backup/media.tgz /storage/Backups/$(hostname)_$(date +"%Y%m%d")/media.tgz


# Backup plexmediaserver config directory
sudo tar -zcf /backup/plexmediaserver.tgz \
 --exclude='/docker/plexmediaserver/Library/Application Support/Plex Media Server/Cache/*' \
 --exclude='/docker/plexmediaserver/Library/Application Support/Plex Media Server/Logs/*' \
 --exclude='/docker/plexmediaserver/Library/Application Support/Plex Media Server/Media/*' \
 --exclude='/docker/plexmediaserver/Library/Application Support/Plex Media Server/Metadata/*' \
 -c /docker/plexmediaserver
 /
# Move the archive to external storage for backing up
mv /backup/plexmediaserver.tgz /storage/Backups/$(hostname)_$(date +"%Y%m%d")/plexmediaserver.tgz
