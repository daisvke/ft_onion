#!/usr/bin/env bash

# Tor

# Fix permissions for the hidden service directory
chown -R debian-tor:debian-tor /var/lib/tor
chmod -R 700 /var/lib/tor


# SSH

# Set default values if not provided
# (`:-` is the default value operator in bash)
SSH_USER=${SSH_USER:-admin}
SSH_PWD=${SSH_PWD:-password}

# Create the user (if not exists) and set password
useradd -m -s /bin/bash "$SSH_USER"
echo "$SSH_USER:$SSH_PWD" | chpasswd

# Create and give permissions to the log file
touch /var/log/auth.log
chmod 640 /var/log/auth.log


# Start services

service tor start
service ssh start
syslogd
service fail2ban start

# Start Nginx in the foreground (to keep the container running)
nginx -g 'daemon off;'
