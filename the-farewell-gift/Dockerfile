# =====================================================
# THE FAREWELL GIFT - CTF Challenge
# Exploit3rs Cyber Security Academy
# =====================================================
# Ubuntu 20.04 with vulnerable Polkit (CVE-2021-4034)
# =====================================================

FROM ubuntu:20.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# =====================================================
# INSTALL BASE PACKAGES
# =====================================================

RUN apt-get update && apt-get install -y \
    # Core utilities
    curl \
    wget \
    vim \
    nano \
    git \
    gcc \
    make \
    # Networking
    net-tools \
    iputils-ping \
    # Web server
    nginx \
    # Process management
    supervisor \
    # Polkit (vulnerable version)
    policykit-1 \
    # Misc
    locales \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# =====================================================
# INSTALL TTYD (Web Terminal)
# =====================================================

# Install ttyd from GitHub releases
RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

# =====================================================
# CREATE CHALLENGE USER
# =====================================================

# Create kevin-debug user with limited privileges
RUN useradd -m -s /bin/bash -u 1000 kevin-debug \
    && echo "kevin-debug:kevin123" | chpasswd

# =====================================================
# SETUP CHALLENGE FILES
# =====================================================

# Copy setup scripts
COPY setup/create-files.sh /opt/setup/create-files.sh
COPY setup/bashrc /opt/setup/bashrc

# Run setup script to create challenge files
RUN chmod +x /opt/setup/create-files.sh && /opt/setup/create-files.sh

# =====================================================
# CONFIGURE NGINX
# =====================================================

# Remove default nginx config
RUN rm -f /etc/nginx/sites-enabled/default

# Copy custom nginx config
COPY nginx/default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Copy web files
COPY web/ /var/www/html/

# Set proper permissions for web files
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# =====================================================
# VERIFY VULNERABLE POLKIT
# =====================================================

# Ensure pkexec is SUID root (required for CVE-2021-4034)
RUN chmod 4755 /usr/bin/pkexec

# Verify polkit version (should be < 0.120 for vulnerability)
RUN pkexec --version || true

# =====================================================
# CONFIGURE SUPERVISOR
# =====================================================

COPY <<'EOF' /etc/supervisor/conf.d/services.conf
[supervisord]
nodaemon=true
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor

[program:nginx]
command=/usr/sbin/nginx -g "daemon off;"
autostart=true
autorestart=true
stderr_logfile=/var/log/nginx/error.log
stdout_logfile=/var/log/nginx/access.log

[program:ttyd]
command=/usr/local/bin/ttyd -p 7681 -t fontSize=14 -t fontFamily="JetBrains Mono, monospace" -t theme={"background":"#0a0a0a","foreground":"#00ff41","cursor":"#00ff41","selection":"rgba(0,255,65,0.3)"} -W /bin/bash -l
user=kevin-debug
directory=/home/kevin-debug
autostart=true
autorestart=true
stderr_logfile=/var/log/ttyd/error.log
stdout_logfile=/var/log/ttyd/access.log
environment=HOME="/home/kevin-debug",USER="kevin-debug",SHELL="/bin/bash",TERM="xterm-256color"
EOF

# Create log directories
RUN mkdir -p /var/log/supervisor /var/log/ttyd \
    && touch /var/log/ttyd/error.log /var/log/ttyd/access.log \
    && chmod 755 /var/log/ttyd

# =====================================================
# FINAL SETUP
# =====================================================

# Expose ports
EXPOSE 80 7681

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
