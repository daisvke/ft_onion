FROM debian:latest

RUN apt update && \
	apt install -y tor nginx openssh-server && \
	apt install -y inetutils-syslogd && \
	rm -rf /var/lib/apt/lists/*

# Copy the setup script into the container
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Configure Tor
COPY config/torrc /etc/tor/torrc

# Configure Nginx
RUN mkdir -p /var/www/html
COPY html/index.html /var/www/html/
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure SSH
COPY config/sshd_config /etc/ssh/sshd_config
# This directory is often used by the SSH daemon to store runtime data,
# such as PID files or socket files.
#
# It is a common practice to create this directory to ensure that the
# SSH server can start correctly.
RUN mkdir /run/sshd

EXPOSE 80 4242

ENTRYPOINT [ "/usr/local/bin/setup.sh" ]