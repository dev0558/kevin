# =====================================================
# THE FAREWELL GIFT v2 - Hard Mode CTF
# Exploit3rs Cyber Security Academy
# =====================================================
# CVE-2019-14287 - Sudo User ID Bypass
# Ubuntu 18.04 with vulnerable sudo (< 1.8.28)
# =====================================================

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# =====================================================
# INSTALL PACKAGES (keeping sudo vulnerable)
# =====================================================

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    vim \
    nano \
    git \
    gcc \
    make \
    net-tools \
    iputils-ping \
    nginx \
    supervisor \
    sudo \
    locales \
    ca-certificates \
    file \
    binutils \
    && rm -rf /var/lib/apt/lists/*

# Verify sudo version is vulnerable (< 1.8.28)
RUN sudo --version | head -1

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# =====================================================
# INSTALL TTYD (Web Terminal)
# =====================================================

RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

# =====================================================
# CREATE CHALLENGE USER
# =====================================================

RUN useradd -m -s /bin/bash -u 1000 kevin-debug \
    && echo "kevin-debug:kevin123" | chpasswd

# =====================================================
# CONFIGURE VULNERABLE SUDOERS
# =====================================================

COPY setup/sudoers /etc/sudoers.d/kevin-debug
RUN chmod 440 /etc/sudoers.d/kevin-debug

# =====================================================
# SETUP CHALLENGE FILES
# =====================================================

COPY setup/create-files.sh /opt/setup/create-files.sh
COPY setup/bashrc /opt/setup/bashrc
RUN chmod +x /opt/setup/create-files.sh && /opt/setup/create-files.sh

# =====================================================
# CONFIGURE NGINX
# =====================================================

RUN rm -f /etc/nginx/sites-enabled/default
COPY nginx/default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY web/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# =====================================================
# CONFIGURE SUPERVISOR
# =====================================================

COPY <<'EOF' /etc/supervisor/conf.d/services.conf
[supervisord]
nodaemon=true
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid

[program:nginx]
command=/usr/sbin/nginx -g "daemon off;"
autostart=true
autorestart=true

[program:ttyd]
command=/usr/local/bin/ttyd -p 7681 -t fontSize=14 -t fontFamily="JetBrains Mono, monospace" -t theme={"background":"#0a0a0a","foreground":"#00ff41","cursor":"#00ff41"} -W /bin/bash -l
user=kevin-debug
directory=/home/kevin-debug
autostart=true
autorestart=true
environment=HOME="/home/kevin-debug",USER="kevin-debug",SHELL="/bin/bash",TERM="xterm-256color"
EOF

RUN mkdir -p /var/log/supervisor /var/log/ttyd \
    && touch /var/log/ttyd/error.log /var/log/ttyd/access.log

# =====================================================
# FINAL SETUP
# =====================================================

EXPOSE 80 7681
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost/ || exit 1
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
