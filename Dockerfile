FROM debian:latest

RUN apt update && apt install -y tor nginx openssh-server && rm -rf /var/lib/apt/lists/*

# Configure Tor
# RUN echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc && \
#     echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc && \
#     echo "HiddenServicePort 4242 127.0.0.1:22" >> /etc/tor/torrc
    
# Copy the setup script into the container
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Configure Nginx
RUN mkdir -p /var/www/html
COPY html/index.html /var/www/html/
COPY nginx.conf /etc/nginx/nginx.conf

# Configure SSH
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /run/sshd

EXPOSE 80 4242

# CMD service tor start && nginx -g 'daemon off;' && /usr/sbin/sshd -D