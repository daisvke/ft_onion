#!/bin/bash

# Tor

# Fix permissions for the hidden service directory
# Permissions are overridden if done from the Dockerfile
chown -R debian-tor:debian-tor /var/lib/tor
chmod -R 700 /var/lib/tor


# SSH

# Set default values if not provided
# (`:-` is the default value operator in bash)
SSH_USER=${SSH_USER:-admin}
SSH_PASS=${SSH_PASS:-password}

# Create the user (if not exists) and set password
useradd -m -s /bin/bash "$SSH_USER"
echo "$SSH_USER:$SSH_PASS" | chpasswd


# Services

# Start Tor
service tor start
# Start SSH
service ssh start
# Start Nginx in the foreground (to keep the container running)
nginx -g 'daemon off;'
