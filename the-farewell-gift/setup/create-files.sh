#!/bin/bash
# =====================================================
# THE FAREWELL GIFT - Challenge File Setup Script
# Exploit3rs Cyber Security Academy
# =====================================================

set -e

echo "[*] Creating challenge directory structure..."

# =====================================================
# HOME DIRECTORY FILES (/home/kevin-debug/)
# =====================================================

# Create notes directory
mkdir -p /home/kevin-debug/notes

# README.txt
cat > /home/kevin-debug/README.txt << 'EOFREADME'
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   N I M B U S   T E C H N O L O G I E S                          ║
║   Debug Terminal - FOR INTERNAL USE ONLY                         ║
║                                                                  ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
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
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
EOFREADME

# .bash_history
cat > /home/kevin-debug/.bash_history << 'EOFHISTORY'
whoami
id
ls -la
cd /opt
ls -la
cd nimbus
cat debug.log
cd /var/backups
ls -la
cd kevin_stuff
ls -la
cd /tmp
mkdir .k3v1n
cd .k3v1n
nano hints.txt
clear
EOFHISTORY

# notes/todo.txt
cat > /home/kevin-debug/notes/todo.txt << 'EOFTODO'
┌────────────────────────────────────┐
│   KEVIN'S TODO LIST                │
├────────────────────────────────────┤
│                                    │
│   [✓] Get revenge                  │
│   [✓] Hide tracks                  │
│   [✓] Leave gift for next person   │
│   [ ] Update LinkedIn              │
│   [ ] Touch grass                  │
│                                    │
└────────────────────────────────────┘
EOFTODO

# Copy custom .bashrc
cp /opt/setup/bashrc /home/kevin-debug/.bashrc

# Set ownership
chown -R kevin-debug:kevin-debug /home/kevin-debug/

# =====================================================
# /opt/nimbus/ FILES
# =====================================================

mkdir -p /opt/nimbus/logs

# .kevin_was_here (hidden file)
cat > /opt/nimbus/.kevin_was_here << 'EOFKEVIN'
░█░█░█▀█░█░█░░░█▀▀░█▀█░█░█░█▀█░█▀▄░░░█▄█░█▀▀░█
░░█░░█░█░█░█░░░█▀▀░█░█░█░█░█░█░█░█░░░█░█░█▀▀░▀
░░▀░░▀▀▀░▀▀▀░░░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░░░░▀░▀░▀▀▀░▀

But this isn't the prize.

Keep looking... and maybe check the logs?

~ K
EOFKEVIN

# logs/debug.log
cat > /opt/nimbus/logs/debug.log << 'EOFDEBUG'
[2024-01-15 09:23:11] [INFO]  Server started
[2024-01-15 09:23:15] [INFO]  Loading modules...
[2024-01-15 10:45:33] [WARN]  pkexec acting weird lately
[2024-01-15 10:45:34] [TODO]  update polkit when we get time
[2024-01-15 11:00:00] [KEVIN] lol they'll never update it
[2024-01-15 14:22:18] [INFO]  Server running normally
[2024-01-15 23:47:33] [ALERT] Unauthorized login: kevin-debug
[2024-01-15 23:59:59] [KEVIN] bye bye :)
EOFDEBUG

# Set permissions (readable by all)
chmod -R 755 /opt/nimbus
chmod 644 /opt/nimbus/.kevin_was_here
chmod 644 /opt/nimbus/logs/debug.log

# =====================================================
# /var/backups/kevin_stuff/ FILES
# =====================================================

mkdir -p /var/backups/kevin_stuff/memes

# memes/skill_issue.txt (red herring)
cat > /var/backups/kevin_stuff/memes/skill_issue.txt << 'EOFSKILL'

    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀
    ⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀
    ⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀
    ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
    ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
    ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
    ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
    ⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀
    ⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀
    ⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀

    You really thought the flag was here?

    S K I L L   I S S U E

    Keep looking, nerd.

EOFSKILL

# .secret_note.txt (hidden - important clue)
cat > /var/backups/kevin_stuff/.secret_note.txt << 'EOFSECRET'
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                  ┃
┃   You're on the right track.                     ┃
┃                                                  ┃
┃   The REAL prize is in /root/kevin_farewell/     ┃
┃                                                  ┃
┃   But you're just a lowly "kevin-debug" user.    ┃
┃   How are you gonna get root access?             ┃
┃                                                  ┃
┃   Think about what you've learned:               ┃
┃   ─────────────────────────────────              ┃
┃   > Something about pkexec                       ┃
┃   > Something about a kit                        ┃
┃   > Something about 2021                         ┃
┃                                                  ┃
┃   Put it together, big brain.                    ┃
┃                                                  ┃
┃   - Kevin                                        ┃
┃                                                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
EOFSECRET

# Set permissions
chmod -R 755 /var/backups/kevin_stuff
chmod 644 /var/backups/kevin_stuff/.secret_note.txt

# =====================================================
# /tmp/.k3v1n/ FILES (hidden directory)
# =====================================================

mkdir -p /tmp/.k3v1n

# hints.txt
cat > /tmp/.k3v1n/hints.txt << 'EOFHINTS'
╭─────────────────────────────────────────╮
│                                         │
│   Alright, final hint. I'm too nice.    │
│                                         │
│   CVE-2021-XXXX                         │
│                                         │
│   The last 4 digits? Figure it out.     │
│   Google is free.                       │
│                                         │
│   pwn... something... kit...            │
│                                         │
│   You got this (maybe).                 │
│                                         │
╰─────────────────────────────────────────╯
EOFHINTS

# Set permissions
chmod -R 755 /tmp/.k3v1n
chmod 644 /tmp/.k3v1n/hints.txt

# =====================================================
# /root/kevin_farewell/ FILES (only root can access)
# =====================================================

mkdir -p /root/kevin_farewell

# goodbye.txt
cat > /root/kevin_farewell/goodbye.txt << 'EOFGOODBYE'

    ██████╗ ██╗   ██╗███████╗    ██████╗ ██╗   ██╗███████╗
    ██╔══██╗╚██╗ ██╔╝██╔════╝    ██╔══██╗╚██╗ ██╔╝██╔════╝
    ██████╔╝ ╚████╔╝ █████╗      ██████╔╝ ╚████╔╝ █████╗
    ██╔══██╗  ╚██╔╝  ██╔══╝      ██╔══██╗  ╚██╔╝  ██╔══╝
    ██████╔╝   ██║   ███████╗    ██████╔╝   ██║   ███████╗
    ╚═════╝    ╚═╝   ╚══════╝    ╚═════╝    ╚═╝   ╚══════╝

    ┌─────────────────────────────────────────────────────┐
    │                                                     │
    │   Dear Nimbus Technologies,                         │
    │                                                     │
    │   Roses are red,                                    │
    │   Violets are blue,                                 │
    │   Your polkit was vulnerable,                       │
    │   And now I'm root too.                             │
    │                                                     │
    │   Thanks for the memories (and the CVE).            │
    │                                                     │
    │   No hard feelings... okay maybe a little.          │
    │                                                     │
    │   ███████╗██╗  ██╗██╗██╗     ██╗                    │
    │   ██╔════╝██║ ██╔╝██║██║     ██║                    │
    │   ███████╗█████╔╝ ██║██║     ██║                    │
    │   ╚════██║██╔═██╗ ██║██║     ██║                    │
    │   ███████║██║  ██╗██║███████╗███████╗               │
    │   ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝               │
    │                                                     │
    │   ██╗███████╗███████╗██╗   ██╗███████╗              │
    │   ██║██╔════╝██╔════╝██║   ██║██╔════╝              │
    │   ██║███████╗███████╗██║   ██║█████╗                │
    │   ██║╚════██║╚════██║██║   ██║██╔══╝                │
    │   ██║███████║███████║╚██████╔╝███████╗              │
    │   ╚═╝╚══════╝╚══════╝ ╚═════╝ ╚══════╝              │
    │                                                     │
    │   - Kevin                                           │
    │                                                     │
    │   P.S. I took the good snacks from the break room.  │
    │                                                     │
    └─────────────────────────────────────────────────────┘

EOFGOODBYE

# flag.txt
cat > /root/kevin_farewell/flag.txt << 'EOFFLAG'

    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║   ░█▀▀░█░░░█▀█░█▀▀░░░█▀▀░█▀█░█▀█░▀█▀░█░█░█▀▄░█▀▀░█▀▄░█       ║
    ║   ░█▀▀░█░░░█▀█░█░█░░░█░░░█▀█░█▀▀░░█░░█░█░█▀▄░█▀▀░█░█░▀       ║
    ║   ░▀░░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀░▀░▀░░░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀░░▀       ║
    ║                                                               ║
    ╠═══════════════════════════════════════════════════════════════╣
    ║                                                               ║
    ║   EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}                   ║
    ║                                                               ║
    ╠═══════════════════════════════════════════════════════════════╣
    ║                                                               ║
    ║   Congratulations! You found Kevin's farewell gift.           ║
    ║                                                               ║
    ║   Skills demonstrated:                                        ║
    ║   > Linux filesystem exploration                              ║
    ║   > Hidden file discovery                                     ║
    ║   > CVE research                                              ║
    ║   > Privilege escalation (CVE-2021-4034)                      ║
    ║                                                               ║
    ║   Kevin would be proud. Maybe.                                ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝

EOFFLAG

# Set strict permissions (only root can access)
chmod 700 /root/kevin_farewell
chmod 600 /root/kevin_farewell/*

echo "[*] Challenge files created successfully!"
echo "[*] Directory structure:"
echo "    /home/kevin-debug/"
echo "    ├── README.txt"
echo "    ├── .bash_history"
echo "    ├── .bashrc"
echo "    └── notes/"
echo "        └── todo.txt"
echo "    /opt/nimbus/"
echo "    ├── .kevin_was_here"
echo "    └── logs/"
echo "        └── debug.log"
echo "    /var/backups/kevin_stuff/"
echo "    ├── memes/"
echo "    │   └── skill_issue.txt"
echo "    └── .secret_note.txt"
echo "    /tmp/.k3v1n/"
echo "    └── hints.txt"
echo "    /root/kevin_farewell/"
echo "    ├── goodbye.txt"
echo "    └── flag.txt"
