#!/bin/bash

# Check if we should use a persistent onion address or not
# if [ "$ONION_PERSISTENT" == "true" ]; then
#     echo "Setting up persistent onion address..."
#     # Create a persistent hidden service
#     mkdir -p /var/lib/tor/hidden_service
#     chown -R debian-tor:debian-tor /var/lib/tor/hidden_service
#     chmod -R 700 /var/lib/tor/hidden_service

#     # Configure Tor for a persistent onion address
#     echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc
# else
#     echo "Setting up non-persistent onion address..."
    # Configure Tor for a non-persistent hidden service (no specific directory)
# fi

echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc
echo "HiddenServicePort 4242 127.0.0.1:22" >> /etc/tor/torrc

# Fix permissions for the hidden service directory
chown -R debian-tor:debian-tor /var/lib/tor
chmod -R 700 /var/lib/tor

# Start the services
service tor start
nginx -g 'daemon off;'
/usr/sbin/sshd -D
