#!/bin/bash

# Tor

# Fix permissions for the hidden service directory
chown -R debian-tor:debian-tor /var/lib/tor
chmod -R 700 /var/lib/tor

# PHP website

# Choose an owner having sufficient permissions to write on the file
# chown www-data:www-data /var/www/html/data.csv

# Apply usual modes for folders/files
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;


# SSH

# Set default values if not provided
# (`:-` is the default value operator in bash)
SSH_USER=${SSH_USER:-admin}
SSH_PWD=${SSH_PWD:-password}

# Create the user (if not exists) and set password
useradd -m -s /bin/bash "$SSH_USER"
echo "$SSH_USER:$SSH_PWD" | chpasswd
# Let the user be the owner of his home folder
chown "$SSH_USER":"$SSH_USER" /home/"$SSH_USER"/

# Create and give permissions to the log file
touch /var/log/auth.log
chmod 640 /var/log/auth.log
# To track users connected via SSH (`who`, `w`, `users` commands)
touch /var/run/utmp
chmod 640 /var/run/utmp

# Start services

service tor start
service ssh start
syslogd
service fail2ban start
service php8.2-fpm start

# Start Nginx in the foreground (to keep the container running)
#
# In a Docker container, the main process of the container should
# 	run in the foreground. If the main process exits, the container stops.
# By running Nginx in the foreground, you ensure that the container
# remains running as long as Nginx is active.
#
# The `-g` option allows us to specify global directives for Nginx.

nginx -g 'daemon off;'
