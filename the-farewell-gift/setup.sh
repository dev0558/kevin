#!/bin/bash
# =====================================================
# THE FAREWELL GIFT - One-Click Setup Script
# Exploit3rs Cyber Security Academy
# =====================================================
# Run this script to create the entire CTF challenge
# Usage: bash setup.sh
# =====================================================

set -e

PROJECT_DIR="the-farewell-gift"

echo "
  ███╗   ██╗██╗███╗   ███╗██████╗ ██╗   ██╗███████╗
  ████╗  ██║██║████╗ ████║██╔══██╗██║   ██║██╔════╝
  ██╔██╗ ██║██║██╔████╔██║██████╔╝██║   ██║███████╗
  ██║╚██╗██║██║██║╚██╔╝██║██╔══██╗██║   ██║╚════██║
  ██║ ╚████║██║██║ ╚═╝ ██║██████╔╝╚██████╔╝███████║
  ╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝ ╚══════╝
                    THE FAREWELL GIFT CTF
"

echo "[*] Creating project structure..."
mkdir -p "$PROJECT_DIR"/{nginx,web,setup}

# =====================================================
# DOCKERFILE
# =====================================================
echo "[*] Creating Dockerfile..."
cat > "$PROJECT_DIR/Dockerfile" << 'DOCKERFILEEOF'
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    curl wget vim nano git gcc make \
    net-tools iputils-ping nginx supervisor \
    policykit-1 locales ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

RUN useradd -m -s /bin/bash -u 1000 kevin-debug \
    && echo "kevin-debug:kevin123" | chpasswd

COPY setup/create-files.sh /opt/setup/create-files.sh
COPY setup/bashrc /opt/setup/bashrc
RUN chmod +x /opt/setup/create-files.sh && /opt/setup/create-files.sh

RUN rm -f /etc/nginx/sites-enabled/default
COPY nginx/default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY web/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

RUN chmod 4755 /usr/bin/pkexec

RUN mkdir -p /var/log/supervisor /var/log/ttyd \
    && touch /var/log/ttyd/error.log /var/log/ttyd/access.log

COPY <<'SUPERVISOREOF' /etc/supervisor/conf.d/services.conf
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
SUPERVISOREOF

EXPOSE 80 7681
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost/ || exit 1
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
DOCKERFILEEOF

# =====================================================
# DOCKER-COMPOSE
# =====================================================
echo "[*] Creating docker-compose.yml..."
cat > "$PROJECT_DIR/docker-compose.yml" << 'COMPOSEEOF'
version: '3.8'

services:
  farewell-gift:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: kevin-farewell-gift
    hostname: nimbus-debug
    ports:
      - "8080:80"
      - "7681:7681"
    restart: unless-stopped
    security_opt:
      - no-new-privileges:false
    stdin_open: true
    tty: true
COMPOSEEOF

# =====================================================
# NGINX CONFIG
# =====================================================
echo "[*] Creating nginx config..."
cat > "$PROJECT_DIR/nginx/default.conf" << 'NGINXEOF'
server {
    listen 80 default_server;
    server_name _;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /terminal/ {
        proxy_pass http://127.0.0.1:7681/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_read_timeout 86400s;
        proxy_send_timeout 86400s;
        proxy_buffering off;
    }
}
NGINXEOF

# =====================================================
# LANDING PAGE HTML
# =====================================================
echo "[*] Creating landing page..."
cat > "$PROJECT_DIR/web/index.html" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NIMBUS TECHNOLOGIES - Debug Terminal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <canvas id="matrix-rain"></canvas>
    <div class="crt-container">
        <div class="crt scanlines">
            <div class="screen-content">
                <div id="boot-sequence" class="boot-sequence">
                    <div class="boot-line" data-delay="0">> NIMBUS TECHNOLOGIES - INTERNAL SYSTEMS</div>
                    <div class="boot-line" data-delay="400">> Initializing secure connection...</div>
                    <div class="boot-line" data-delay="800">> Bypassing firewall<span class="dots"></span> <span class="status">[OK]</span></div>
                    <div class="boot-line" data-delay="1400">> Loading debug environment<span class="dots"></span> <span class="status">[OK]</span></div>
                    <div class="boot-line" data-delay="2000">> Authenticating<span class="dots"></span> <span class="status">[OK]</span></div>
                    <div class="boot-line" data-delay="2600">&nbsp;</div>
                    <div class="boot-line warning" data-delay="2800">> WARNING: Unauthorized access detected</div>
                    <div class="boot-line" data-delay="3200">> User: kevin-debug (TERMINATED EMPLOYEE)</div>
                    <div class="boot-line" data-delay="3600">> Last login: Fri Jan 15 23:47:33 2024</div>
                </div>
                <div id="main-content" class="main-content hidden">
                    <div class="separator">============================================</div>
                    <pre class="ascii-logo glow">
  ███╗   ██╗██╗███╗   ███╗██████╗ ██╗   ██╗███████╗
  ████╗  ██║██║████╗ ████║██╔══██╗██║   ██║██╔════╝
  ██╔██╗ ██║██║██╔████╔██║██████╔╝██║   ██║███████╗
  ██║╚██╗██║██║██║╚██╔╝██║██╔══██╗██║   ██║╚════██║
  ██║ ╚████║██║██║ ╚═╝ ██║██████╔╝╚██████╔╝███████║
  ╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝ ╚══════╝
                                   <span class="subtitle">TECHNOLOGIES</span></pre>
                    <div class="separator">============================================</div>
                    <div class="incident-report">
                        <div class="report-header glow">INCIDENT REPORT #4471</div>
                        <div class="report-divider">----------------------</div>
                        <br>
                        <p>Our ex-intern <span class="highlight">"Kevin"</span> was let go last week after he</p>
                        <p>mass-replied <span class="highlight">"skill issue"</span> to an executive email thread.</p>
                        <br>
                        <p>Before leaving, Kevin claims he hid a <span class="highlight">"farewell gift"</span></p>
                        <p>somewhere on this server. IT has locked down SSH access,</p>
                        <p>but Kevin left behind a debug terminal.</p>
                        <br>
                        <p class="mission">Your mission: <span class="highlight">Escalate privileges and find Kevin's gift.</span></p>
                        <br>
                        <div class="slack-status">
                            <span class="slack-label">Kevin's last Slack status:</span>
                            <span class="slack-message glitch" data-text='"they mass mass mass mass but do they kit kit kit?"'>"they mass mass mass mass but do they kit kit kit?"</span>
                        </div>
                    </div>
                    <div class="separator">============================================</div>
                    <button id="connect-btn" class="connect-btn" onclick="connectToTerminal()">
                        <span class="btn-bracket">[</span>
                        <span class="btn-text">CONNECT TO DEBUG TERMINAL</span>
                        <span class="btn-bracket">]</span>
                    </button>
                    <div class="footer">
                        <span class="blink">_</span> Press button to initialize connection <span class="blink">_</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="flicker-overlay"></div>
    <script src="script.js"></script>
</body>
</html>
HTMLEOF

# =====================================================
# CSS STYLES
# =====================================================
echo "[*] Creating styles..."
cat > "$PROJECT_DIR/web/style.css" << 'CSSEOF'
:root {
    --phosphor-green: #00ff41;
    --phosphor-green-dim: #00cc33;
    --amber: #ffb000;
    --bg-black: #0a0a0a;
    --warning-red: #ff3333;
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    background: var(--bg-black);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'JetBrains Mono', monospace;
    color: var(--phosphor-green);
    overflow: hidden;
}
#matrix-rain {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    z-index: 0;
    opacity: 0.15;
}
.crt-container {
    position: relative;
    z-index: 1;
    width: 90%;
    max-width: 900px;
    padding: 20px;
}
.crt {
    background: #0d0d0d;
    border: 3px solid var(--phosphor-green-dim);
    border-radius: 20px;
    padding: 40px;
    position: relative;
    overflow: hidden;
    box-shadow: 0 0 20px rgba(0,255,65,0.3), 0 0 40px rgba(0,255,65,0.2), inset 0 0 100px rgba(0,0,0,0.9);
    animation: crt-flicker 0.15s infinite;
}
.crt::before {
    content: "";
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: radial-gradient(ellipse at center, transparent 0%, rgba(0,0,0,0.2) 80%, rgba(0,0,0,0.6) 100%);
    pointer-events: none;
    z-index: 10;
}
.scanlines::after {
    content: "";
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: repeating-linear-gradient(0deg, rgba(0,0,0,0.15), rgba(0,0,0,0.15) 1px, transparent 1px, transparent 2px);
    pointer-events: none;
    z-index: 11;
    animation: scanlines-move 10s linear infinite;
}
@keyframes scanlines-move { 0% { transform: translateY(0); } 100% { transform: translateY(4px); } }
@keyframes crt-flicker {
    0% { opacity: 0.97; } 50% { opacity: 1; } 100% { opacity: 0.98; }
}
.flicker-overlay {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    pointer-events: none;
    z-index: 100;
    animation: screen-flicker 8s infinite;
}
@keyframes screen-flicker {
    0%, 100% { opacity: 0; }
    93% { opacity: 0.1; background: rgba(255,255,255,0.03); }
    94%, 97% { opacity: 0; }
    98% { opacity: 0.05; background: rgba(255,255,255,0.02); }
}
.boot-line {
    opacity: 0;
    transform: translateX(-10px);
    font-size: 14px;
    line-height: 1.8;
}
.boot-line.visible {
    opacity: 1;
    transform: translateX(0);
    transition: opacity 0.3s ease, transform 0.3s ease;
}
.boot-line.warning { color: var(--warning-red); text-shadow: 0 0 10px var(--warning-red); }
.boot-line .status { color: var(--phosphor-green); font-weight: bold; }
.main-content { text-align: center; animation: fade-in 0.5s ease; }
.main-content.hidden { display: none; }
@keyframes fade-in { from { opacity: 0; } to { opacity: 1; } }
.separator { color: var(--phosphor-green-dim); margin: 20px 0; font-size: 12px; }
.ascii-logo {
    font-size: 10px;
    line-height: 1.1;
    margin: 20px 0;
    white-space: pre;
    display: inline-block;
    text-align: left;
}
.glow {
    text-shadow: 0 0 5px var(--phosphor-green), 0 0 10px var(--phosphor-green), 0 0 20px var(--phosphor-green);
    animation: glow-pulse 2s ease-in-out infinite alternate;
}
@keyframes glow-pulse {
    from { text-shadow: 0 0 5px var(--phosphor-green), 0 0 10px var(--phosphor-green); }
    to { text-shadow: 0 0 10px var(--phosphor-green), 0 0 20px var(--phosphor-green), 0 0 30px var(--phosphor-green); }
}
.incident-report { text-align: left; padding: 20px 40px; font-size: 14px; line-height: 1.6; }
.report-header { font-size: 18px; font-weight: bold; margin-bottom: 5px; }
.report-divider { color: var(--phosphor-green-dim); }
.highlight { color: var(--amber); font-weight: bold; text-shadow: 0 0 10px var(--amber); }
.slack-status {
    margin-top: 20px;
    padding: 15px;
    border: 1px dashed var(--phosphor-green-dim);
    background: rgba(0,255,65,0.05);
}
.slack-label { color: var(--phosphor-green-dim); display: block; margin-bottom: 5px; font-size: 12px; }
.glitch { position: relative; animation: glitch-skew 1s infinite linear alternate-reverse; }
.glitch::before, .glitch::after {
    content: attr(data-text);
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 100%;
}
.glitch::before { left: 2px; text-shadow: -2px 0 #ff00ff; clip: rect(44px, 450px, 56px, 0); animation: glitch-anim 5s infinite linear alternate-reverse; }
.glitch::after { left: -2px; text-shadow: -2px 0 #00ffff; clip: rect(44px, 450px, 56px, 0); animation: glitch-anim2 5s infinite linear alternate-reverse; }
@keyframes glitch-anim { 0% { clip: rect(31px, 9999px, 94px, 0); } 50% { clip: rect(67px, 9999px, 89px, 0); } 100% { clip: rect(12px, 9999px, 89px, 0); } }
@keyframes glitch-anim2 { 0% { clip: rect(65px, 9999px, 100px, 0); } 50% { clip: rect(45px, 9999px, 23px, 0); } 100% { clip: rect(89px, 9999px, 56px, 0); } }
@keyframes glitch-skew { 0%, 20%, 23%, 100% { transform: skew(0deg); } 21% { transform: skew(1deg); } 22% { transform: skew(-1deg); } }
.connect-btn {
    background: transparent;
    border: 2px solid var(--phosphor-green);
    color: var(--phosphor-green);
    font-family: 'JetBrains Mono', monospace;
    font-size: 18px;
    padding: 15px 40px;
    cursor: pointer;
    margin: 30px 0;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 3px;
}
.connect-btn::before {
    content: "";
    position: absolute;
    top: 0; left: -100%;
    width: 100%; height: 100%;
    background: linear-gradient(90deg, transparent, rgba(0,255,65,0.2), transparent);
    transition: left 0.5s ease;
}
.connect-btn:hover {
    background: rgba(0,255,65,0.1);
    box-shadow: 0 0 20px var(--phosphor-green), 0 0 40px var(--phosphor-green);
    text-shadow: 0 0 10px var(--phosphor-green);
}
.connect-btn:hover::before { left: 100%; }
.btn-bracket { color: var(--phosphor-green-dim); }
.btn-text { animation: text-pulse 2s ease-in-out infinite; }
@keyframes text-pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
.footer { margin-top: 20px; font-size: 12px; color: var(--phosphor-green-dim); }
.blink { animation: blink 1s step-end infinite; }
@keyframes blink { 0%, 100% { opacity: 1; } 50% { opacity: 0; } }
.loading-overlay {
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: var(--bg-black);
    z-index: 1000;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease;
}
.loading-overlay.active { opacity: 1; pointer-events: all; }
.loading-text { color: var(--phosphor-green); font-size: 18px; margin-bottom: 20px; }
.loading-bar {
    width: 300px; height: 4px;
    background: #003300;
    border: 1px solid var(--phosphor-green-dim);
    position: relative;
}
.loading-bar::after {
    content: "";
    position: absolute;
    top: 0; left: 0;
    height: 100%; width: 0%;
    background: var(--phosphor-green);
    animation: loading-progress 2s ease-out forwards;
}
@keyframes loading-progress { 0% { width: 0%; } 50% { width: 60%; } 100% { width: 100%; } }
@media (max-width: 768px) { .ascii-logo { font-size: 6px; } }
@media (max-width: 600px) {
    .crt { padding: 20px; }
    .incident-report { padding: 10px 15px; font-size: 12px; }
    .connect-btn { font-size: 14px; padding: 12px 25px; }
}
CSSEOF

# =====================================================
# JAVASCRIPT
# =====================================================
echo "[*] Creating JavaScript..."
cat > "$PROJECT_DIR/web/script.js" << 'JSEOF'
class MatrixRain {
    constructor(canvas) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*ｱｲｳｴｵｶｷｸｹｺ';
        this.fontSize = 14;
        this.resize();
        window.addEventListener('resize', () => this.resize());
    }
    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
        this.columns = Math.floor(this.canvas.width / this.fontSize);
        this.drops = Array(this.columns).fill(1);
    }
    draw() {
        this.ctx.fillStyle = 'rgba(10, 10, 10, 0.05)';
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
        this.ctx.fillStyle = '#00ff41';
        this.ctx.font = this.fontSize + 'px monospace';
        for (let i = 0; i < this.drops.length; i++) {
            const char = this.chars[Math.floor(Math.random() * this.chars.length)];
            this.ctx.fillText(char, i * this.fontSize, this.drops[i] * this.fontSize);
            if (this.drops[i] * this.fontSize > this.canvas.height && Math.random() > 0.975) this.drops[i] = 0;
            this.drops[i]++;
        }
    }
    start() { setInterval(() => this.draw(), 50); }
}

class BootSequence {
    constructor() {
        this.lines = document.querySelectorAll('.boot-line');
        this.mainContent = document.getElementById('main-content');
    }
    async start() {
        for (const line of this.lines) {
            await this.sleep(400);
            line.classList.add('visible');
        }
        await this.sleep(800);
        this.mainContent.classList.remove('hidden');
    }
    sleep(ms) { return new Promise(resolve => setTimeout(resolve, ms)); }
}

function connectToTerminal() {
    const overlay = document.createElement('div');
    overlay.className = 'loading-overlay';
    overlay.innerHTML = '<div class="loading-text">Connecting to debug terminal...</div><div class="loading-bar"></div>';
    document.body.appendChild(overlay);
    requestAnimationFrame(() => overlay.classList.add('active'));
    setTimeout(() => { window.location.href = '/terminal/'; }, 2500);
}

document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('matrix-rain');
    if (canvas) new MatrixRain(canvas).start();
    new BootSequence().start();
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && !document.getElementById('main-content').classList.contains('hidden')) {
            connectToTerminal();
        }
    });
    console.log('%c NIMBUS TECHNOLOGIES ', 'background: #00ff41; color: #000; font-size: 20px;');
    console.log('%c "skill issue" - Kevin ', 'color: #ffb000; font-style: italic;');
});
JSEOF

# =====================================================
# BASHRC
# =====================================================
echo "[*] Creating bashrc..."
cat > "$PROJECT_DIR/setup/bashrc" << 'BASHRCEOF'
case $- in *i*) ;; *) return;; esac
HISTCONTROL=ignoreboth
shopt -s histappend
PS1='\[\e[32m\]kevin-debug@nimbus\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
alias ls='ls --color=auto'
alias ll='ls -alF'
clear
echo -e "\e[32m  ╔═══════════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[32m  ║   █▄▀ █▀▀ █░█ █ █▄░█ ▀ █▀   █▀▄ █▀▀ █▄▄ █░█ █▀▀          ║\e[0m"
echo -e "\e[32m  ║   █░█ ██▄ ▀▄▀ █ █░▀█ ░ ▄█   █▄▀ ██▄ █▄█ █▄█ █▄█          ║\e[0m"
echo -e "\e[32m  ║            T E R M I N A L   v 0 . 1 . 3                  ║\e[0m"
echo -e "\e[33m  ║   Status: ACTIVE (unauthorized)                           ║\e[0m"
echo -e "\e[35m  ║   \"I left you a gift. Come find it.\" - Kevin             ║\e[0m"
echo -e "\e[32m  ╚═══════════════════════════════════════════════════════════╝\e[0m"
echo ""
echo -e "\e[36m  Type 'cat README.txt' to start...\e[0m"
echo ""
BASHRCEOF

# =====================================================
# CREATE FILES SCRIPT
# =====================================================
echo "[*] Creating challenge files script..."
cat > "$PROJECT_DIR/setup/create-files.sh" << 'CREATEEOF'
#!/bin/bash
set -e
mkdir -p /home/kevin-debug/notes
cat > /home/kevin-debug/README.txt << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║   N I M B U S   T E C H N O L O G I E S                          ║
║   Debug Terminal - FOR INTERNAL USE ONLY                         ║
╠══════════════════════════════════════════════════════════════════╣
║   Hey! If you're reading this, IT probably hasn't                ║
║   found this terminal yet. Nice.                                 ║
║                                                                  ║
║   I left some stuff around. Good luck finding it all.            ║
║                                                                  ║
║   Check these places:                                            ║
║   > /opt                                                         ║
║   > /var/backups                                                 ║
║   > /tmp (look closer)                                           ║
║                                                                  ║
║   - Kevin                                                        ║
║                                                                  ║
║   P.S. I'm not mad, I'm just disappointed.                       ║
║        Actually no, I'm mad.                                     ║
╚══════════════════════════════════════════════════════════════════╝
EOF

cat > /home/kevin-debug/notes/todo.txt << 'EOF'
┌────────────────────────────────────┐
│   KEVIN'S TODO LIST                │
├────────────────────────────────────┤
│   [✓] Get revenge                  │
│   [✓] Hide tracks                  │
│   [✓] Leave gift for next person   │
│   [ ] Update LinkedIn              │
│   [ ] Touch grass                  │
└────────────────────────────────────┘
EOF

cp /opt/setup/bashrc /home/kevin-debug/.bashrc
chown -R kevin-debug:kevin-debug /home/kevin-debug/

mkdir -p /opt/nimbus/logs
cat > /opt/nimbus/.kevin_was_here << 'EOF'
░█░█░█▀█░█░█░░░█▀▀░█▀█░█░█░█▀█░█▀▄░░░█▄█░█▀▀░█
░░█░░█░█░█░█░░░█▀▀░█░█░█░█░█░█░█░█░░░█░█░█▀▀░▀
░░▀░░▀▀▀░▀▀▀░░░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░░░░▀░▀░▀▀▀░▀

But this isn't the prize. Keep looking... check the logs?
~ K
EOF

cat > /opt/nimbus/logs/debug.log << 'EOF'
[2024-01-15 09:23:11] [INFO]  Server started
[2024-01-15 10:45:33] [WARN]  pkexec acting weird lately
[2024-01-15 10:45:34] [TODO]  update polkit when we get time
[2024-01-15 11:00:00] [KEVIN] lol they'll never update it
[2024-01-15 23:47:33] [ALERT] Unauthorized login: kevin-debug
[2024-01-15 23:59:59] [KEVIN] bye bye :)
EOF
chmod -R 755 /opt/nimbus

mkdir -p /var/backups/kevin_stuff/memes
cat > /var/backups/kevin_stuff/memes/skill_issue.txt << 'EOF'
    You really thought the flag was here?
    S K I L L   I S S U E
    Keep looking, nerd.
EOF

cat > /var/backups/kevin_stuff/.secret_note.txt << 'EOF'
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   You're on the right track.                     ┃
┃   The REAL prize is in /root/kevin_farewell/     ┃
┃   But you're just a lowly "kevin-debug" user.    ┃
┃                                                  ┃
┃   Think about what you've learned:               ┃
┃   > Something about pkexec                       ┃
┃   > Something about a kit                        ┃
┃   > Something about 2021                         ┃
┃                                                  ┃
┃   Put it together, big brain.  - Kevin           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
EOF
chmod -R 755 /var/backups/kevin_stuff

mkdir -p /tmp/.k3v1n
cat > /tmp/.k3v1n/hints.txt << 'EOF'
╭─────────────────────────────────────────╮
│   Alright, final hint. I'm too nice.    │
│   CVE-2021-XXXX                         │
│   The last 4 digits? Figure it out.     │
│   pwn... something... kit...            │
│   You got this (maybe).                 │
╰─────────────────────────────────────────╯
EOF
chmod -R 755 /tmp/.k3v1n

mkdir -p /root/kevin_farewell
cat > /root/kevin_farewell/goodbye.txt << 'EOF'
    ██████╗ ██╗   ██╗███████╗    ██████╗ ██╗   ██╗███████╗
    ██╔══██╗╚██╗ ██╔╝██╔════╝    ██╔══██╗╚██╗ ██╔╝██╔════╝
    ██████╔╝ ╚████╔╝ █████╗      ██████╔╝ ╚████╔╝ █████╗
    ██╔══██╗  ╚██╔╝  ██╔══╝      ██╔══██╗  ╚██╔╝  ██╔══╝
    ██████╔╝   ██║   ███████╗    ██████╔╝   ██║   ███████╗
    ╚═════╝    ╚═╝   ╚══════╝    ╚═════╝    ╚═╝   ╚══════╝

    Dear Nimbus Technologies,

    Roses are red, Violets are blue,
    Your polkit was vulnerable, And now I'm root too.

    - Kevin
    P.S. I took the good snacks from the break room.
EOF

cat > /root/kevin_farewell/flag.txt << 'EOF'
    ╔═══════════════════════════════════════════════════════════════╗
    ║   EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}                   ║
    ╠═══════════════════════════════════════════════════════════════╣
    ║   Congratulations! You found Kevin's farewell gift.           ║
    ║   Skills demonstrated:                                        ║
    ║   > Linux filesystem exploration                              ║
    ║   > Hidden file discovery                                     ║
    ║   > CVE research                                              ║
    ║   > Privilege escalation (CVE-2021-4034)                      ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
chmod 700 /root/kevin_farewell
chmod 600 /root/kevin_farewell/*
echo "[*] Challenge files created!"
CREATEEOF

chmod +x "$PROJECT_DIR/setup/create-files.sh"

echo "
[✓] Project created successfully!

To run the challenge:
  cd $PROJECT_DIR
  docker-compose up -d --build

Then open: http://localhost:8080

Flag: EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}
"
