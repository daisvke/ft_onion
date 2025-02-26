FROM debian:latest

# Install all the necessary packages and remove the apt cache when finished
RUN apt update && \
	apt install -y vim && \
	apt install -y tor nginx openssh-server php8.2-fpm && \
	apt install -y inetutils-syslogd fail2ban iptables && \
	rm -rf /var/lib/apt/lists/*

# Copy the setup script into the container
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Configure Tor
COPY config/torrc /etc/tor/torrc

# Configure Nginx
RUN mkdir -p /var/www/html
COPY html/slate /var/www/html/slate
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure SSH
COPY config/ssh/sshd_config /etc/ssh/sshd_config
COPY logs/auth.log /var/log/auth.log
COPY config/ssh/authorized_keys /home/user/.ssh/authorized_keys

# This directory is often used by the SSH daemon to store runtime data,
# such as PID files or socket files.
#
# It is a common practice to create this directory to ensure that the
# SSH server can start correctly.
RUN mkdir /run/sshd

# Configure Fail2ban
COPY config/jail.conf /etc/fail2ban/jail.conf
COPY logs/fail2ban.log /var/log/fail2ban.log

EXPOSE 80 4242

ENTRYPOINT [ "/usr/local/bin/setup.sh" ]