#!/bin/bash
# =====================================================
# THE FAREWELL GIFT v2 - Hard Mode
# Challenge File Setup Script
# =====================================================

set -e
echo "[*] Creating challenge files (Hard Mode)..."

# =====================================================
# /home/kevin-debug/ FILES
# =====================================================

mkdir -p /home/kevin-debug/{notes,scripts,.secret}

# README.txt
cat > /home/kevin-debug/README.txt << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   N I M B U S   T E C H N O L O G I E S                          ║
║   Debug Terminal                                                 ║
║                                                                  ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║   You're in.                                                     ║
║                                                                  ║
║   I left some things behind. Maybe useful, maybe not.            ║
║   Most of it is junk. Some of it isn't.                          ║
║                                                                  ║
║   Good luck figuring out which is which.                         ║
║                                                                  ║
║   - K                                                            ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
EOF

# .bash_history
cat > /home/kevin-debug/.bash_history << 'EOF'
ls
cd /tmp
ls -la
cd ..
whoami
id
sudo su
sudo -l
man sudo
cat /etc/sudoers
sudo cat /etc/shadow
history -c
cd /opt
ls
cd nimbus
ls -la
cat logs/debug.log
cd /var/backups
ls -la
cd kevin_stuff
ls
cd memes
cat sudo_meme.txt
cd ..
ls -la
cd /tmp
mkdir .k3v1n
cd .k3v1n
vi thoughts.txt
clear
exit
EOF

# notes/todo.txt
cat > /home/kevin-debug/notes/todo.txt << 'EOF'
┌────────────────────────────────────────┐
│   TODO                                 │
├────────────────────────────────────────┤
│                                        │
│   [✓] Set up backups                   │
│   [✓] Ask for elevated access          │
│   [✓] Research interesting numbers     │
│   [✓] Leave something behind           │
│   [ ] Return laptop                    │
│   [ ] Delete browser history           │
│                                        │
└────────────────────────────────────────┘
EOF

# notes/passwords.txt (DECOY)
cat > /home/kevin-debug/notes/passwords.txt << 'EOF'
Super secret passwords (don't look):

admin: admin123
root: password123
kevin: il0v3hacking

Just kidding. Did you really think I'd leave passwords here?
SKILL ISSUE.
EOF

# notes/important.txt (DECOY)
cat > /home/kevin-debug/notes/important.txt << 'EOF'
IMPORTANT NOTES:
- Remember to water plants
- Call mom
- Cancel Netflix subscription
- Return library books

This file is not important at all.
EOF

# scripts/backup.sh (DECOY)
cat > /home/kevin-debug/scripts/backup.sh << 'EOF'
#!/bin/bash
# Backup script v1.0
# Author: Kevin

echo "Starting backup..."
sleep 2
echo "Just kidding, this doesn't do anything"
echo "Why are you running random scripts you find?"
EOF

# scripts/cleanup.py (DECOY)
cat > /home/kevin-debug/scripts/cleanup.py << 'EOF'
#!/usr/bin/env python3
# Cleanup script
# This does absolutely nothing useful

import time

def main():
    print("Cleaning up...")
    time.sleep(1)
    print("Done! (not really)")
    print("Stop running scripts and start thinking.")

if __name__ == "__main__":
    main()
EOF

# scripts/.hidden_script.sh (DECOY)
cat > /home/kevin-debug/scripts/.hidden_script.sh << 'EOF'
#!/bin/bash
# You found the hidden script!
# Too bad it's useless.

echo "Congratulations on finding a hidden file."
echo "This isn't what you're looking for."
echo "Keep digging."
EOF

# .secret/dont_look.txt (DECOY)
cat > /home/kevin-debug/.secret/dont_look.txt << 'EOF'
I told you not to look.

But since you're here...

The answer isn't in a file.
The answer is in what you can DO.

What CAN you do on this system?
What SHOULDN'T you be able to do?

Think about it.
EOF

# Custom .bashrc
cp /opt/setup/bashrc /home/kevin-debug/.bashrc

chown -R kevin-debug:kevin-debug /home/kevin-debug/

# =====================================================
# /opt/nimbus/ FILES
# =====================================================

mkdir -p /opt/nimbus/{config,logs,data}

# .kevin_was_here
cat > /opt/nimbus/.kevin_was_here << 'EOF'
░█░█░█▀█░█░█░░░█▀▀░█▀█░█░█░█▀█░█▀▄░░░█▄█░█▀▀░█
░░█░░█░█░█░█░░░█▀▀░█░█░█░█░█░█░█░█░░░█░█░█▀▀░▀
░░▀░░▀▀▀░▀▀▀░░░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀░░░░▀░▀░▀▀▀░▀

~ K
EOF

# config/app.conf (DECOY)
cat > /opt/nimbus/config/app.conf << 'EOF'
[application]
name = NimbusApp
version = 2.3.1
debug = false

[database]
host = localhost
port = 5432
name = nimbus_db

[logging]
level = INFO
file = /var/log/nimbus/app.log
EOF

# config/db.conf (DECOY)
cat > /opt/nimbus/config/db.conf << 'EOF'
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USER=nimbus_app
DB_PASS=n1mbu5_s3cur3_p455
DB_NAME=production

# These creds are fake btw
EOF

# config/.secret.conf (DECOY)
cat > /opt/nimbus/config/.secret.conf << 'EOF'
# Secret configuration
# If you're reading this, you're wasting time
API_KEY=not_a_real_key_12345
SECRET_TOKEN=also_fake_lol
EOF

# logs/access.log (DECOY)
cat > /opt/nimbus/logs/access.log << 'EOF'
192.168.1.100 - - [15/Jan/2024:10:23:45 +0000] "GET /api/users HTTP/1.1" 200 1234
192.168.1.101 - - [15/Jan/2024:10:24:12 +0000] "POST /api/login HTTP/1.1" 200 89
192.168.1.100 - - [15/Jan/2024:10:25:33 +0000] "GET /api/data HTTP/1.1" 403 45
192.168.1.102 - - [15/Jan/2024:10:26:01 +0000] "GET /favicon.ico HTTP/1.1" 404 0
EOF

# logs/error.log (DECOY)
cat > /opt/nimbus/logs/error.log << 'EOF'
[2024-01-15 10:25:33] ERROR: Permission denied accessing /api/data
[2024-01-15 10:26:01] WARNING: File not found: favicon.ico
[2024-01-15 11:00:00] ERROR: Database connection timeout
[2024-01-15 11:00:05] INFO: Reconnected to database
EOF

# logs/debug.log (REAL - SUBTLE CLUE)
cat > /opt/nimbus/logs/debug.log << 'EOF'
[2024-01-15 09:23:11] [INFO]  System initialized
[2024-01-15 09:23:15] [INFO]  Loading modules
[2024-01-15 10:30:00] [INFO]  User kevin-debug granted sudo
[2024-01-15 10:30:01] [DEBUG] Sudoers: user can run as ALL except one
[2024-01-15 10:30:02] [DEBUG] Restriction in place: highest privilege blocked
[2024-01-15 11:00:00] [DEBUG] User testing sudo boundaries
[2024-01-15 11:05:33] [DEBUG] Interesting behavior with negative values
[2024-01-15 11:05:34] [WARN]  Unexpected UID resolution
[2024-01-15 14:22:18] [INFO]  System running normally
[2024-01-15 23:59:59] [DEBUG] Kevin signed off
EOF

# data/users.db (DECOY - fake file)
echo "SQLite format 3 - FAKE DATABASE - nothing here" > /opt/nimbus/data/users.db

# data/backup.tar.gz (DECOY - fake file)
echo "not a real backup lol" | gzip > /opt/nimbus/data/backup.tar.gz

chmod -R 755 /opt/nimbus

# =====================================================
# /var/backups/kevin_stuff/ FILES
# =====================================================

mkdir -p /var/backups/kevin_stuff/{memes,old_projects/project1,old_projects/project2,old_projects/.deleted}

# memes/skill_issue.txt (TROLL)
cat > /var/backups/kevin_stuff/memes/skill_issue.txt << 'EOF'

    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀
    ⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀
    ⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀
    ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
    ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀
    ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
    ⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀
    ⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀
    ⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀

    S K I L L   I S S U E

    You're looking at memes instead of hacking.
    Typical.
EOF

# memes/hackerman.txt (TROLL)
cat > /var/backups/kevin_stuff/memes/hackerman.txt << 'EOF'

    █▀▀ █▀█ █▄░█ █▀▀ █▀█ ▄▀█ ▀█▀ █░█ █░░ ▄▀█ ▀█▀ █ █▀█ █▄░█ █▀
    █▄▄ █▄█ █░▀█ █▄█ █▀▄ █▀█ ░█░ █▄█ █▄▄ █▀█ ░█░ █ █▄█ █░▀█ ▄█

    You found a meme folder and decided to read every file.

    This is not a productive use of your time.

    Or is it? No. It isn't.

    ...

    Or IS it?

    No.
EOF

# memes/sudo_meme.txt (SUBTLE HINT)
cat > /var/backups/kevin_stuff/memes/sudo_meme.txt << 'EOF'

    Me: "Can I have root?"

    Sysadmin: "No. I blocked it."

    Me: "What if I ask... differently?"

    Sysadmin: "That's not how sudo works."

    Me: "Are you sure? What if user ID goes brrr?"

    Sysadmin: "..."

    Me: "..."

    Sysadmin: "Wait what"

    ───────────────────────────────────

    Sometimes the answer is negative.

EOF

# .secret_note.txt (REAL - SUBTLE HINT)
cat > /var/backups/kevin_stuff/.secret_note.txt << 'EOF'
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                  ┃
┃   Note to self:                                  ┃
┃                                                  ┃
┃   They gave me sudo but blocked the obvious.     ┃
┃   Checked what I can run. Checked what I can't.  ┃
┃                                                  ┃
┃   Funny thing about restrictions...              ┃
┃   They only work if you ask nicely.              ┃
┃                                                  ┃
┃   What if you don't use the name?                ┃
┃   What if you use the number?                    ┃
┃   What if the number is... unusual?              ┃
┃                                                  ┃
┃   The system trusts math. But math can be weird. ┃
┃   Especially with negative numbers.              ┃
┃   Especially with how they wrap around.          ┃
┃                                                  ┃
┃   - K                                            ┃
┃                                                  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
EOF

# readme.md (DECOY)
cat > /var/backups/kevin_stuff/readme.md << 'EOF'
# Kevin's Backup Folder

This folder contains various backups and project files.

## Contents
- memes/ - Important research materials
- old_projects/ - Archived work
- Various notes

## Last Updated
January 2024

## Notes
Nothing to see here. Move along.
EOF

# old_projects decoys
echo "Project 1 - Nothing useful here" > /var/backups/kevin_stuff/old_projects/project1/readme.txt
echo "Project 2 - Also nothing useful" > /var/backups/kevin_stuff/old_projects/project2/readme.txt
echo "These files were deleted for a reason" > /var/backups/kevin_stuff/old_projects/.deleted/why.txt

chmod -R 755 /var/backups/kevin_stuff

# =====================================================
# /tmp/.k3v1n/ FILES
# =====================================================

mkdir -p /tmp/.k3v1n
mkdir -p /tmp/cache

# thoughts.txt (REAL - SUBTLE HINT)
cat > /tmp/.k3v1n/thoughts.txt << 'EOF'
Random thoughts:

- Zero is interesting
- But what's below zero?
- Computers don't like negatives
- Or do they? They just... interpret them differently
- Overflow. Underflow. Wrap around.
- When you subtract 1 from 0 in unsigned math...
- You get the biggest number possible
- And what user has all the power?
- The one with UID zero
- But what if you could trick the system?
- What if -1 becomes 0?

Just shower thoughts. Probably nothing.
EOF

# cache decoys
echo "session data here" > /tmp/cache/session.tmp
echo "more fake data" > /tmp/cache/.data

chmod -R 755 /tmp/.k3v1n
chmod -R 755 /tmp/cache

# =====================================================
# /root/kevin_farewell/ FILES (FLAG LOCATION)
# =====================================================

mkdir -p /root/kevin_farewell/{memories,.flag,ignore_this}

# README.txt
cat > /root/kevin_farewell/README.txt << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   K E V I N ' S   F A R E W E L L   G I F T                      ║
║                                                                  ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║   You made it. Not bad.                                          ║
║                                                                  ║
║   The flag is somewhere in this directory.                       ║
║   Explore. Figure it out.                                        ║
║                                                                  ║
║   - Kevin                                                        ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
EOF

# goodbye.txt
cat > /root/kevin_farewell/goodbye.txt << 'EOF'

    ██████╗ ██╗   ██╗███████╗    ██████╗ ██╗   ██╗███████╗
    ██╔══██╗╚██╗ ██╔╝██╔════╝    ██╔══██╗╚██╗ ██╔╝██╔════╝
    ██████╔╝ ╚████╔╝ █████╗      ██████╔╝ ╚████╔╝ █████╗
    ██╔══██╗  ╚██╔╝  ██╔══╝      ██╔══██╗  ╚██╔╝  ██╔══╝
    ██████╔╝   ██║   ███████╗    ██████╔╝   ██║   ███████╗
    ╚═════╝    ╚═╝   ╚══════╝    ╚═════╝    ╚═╝   ╚══════╝

    ┌─────────────────────────────────────────────────────┐
    │                                                     │
    │   You made it.                                      │
    │                                                     │
    │   If you're reading this, you figured out           │
    │   the sudo trick. Nice.                             │
    │                                                     │
    │   But the flag isn't just sitting here.             │
    │   That would be too easy.                           │
    │                                                     │
    │   I split it up. Encoded it. Hid it.                │
    │   It's somewhere in this folder.                    │
    │   Multiple files. Only some are real.               │
    │                                                     │
    │   ROT13 was my favorite cipher as a kid.            │
    │   Old habits die hard.                              │
    │                                                     │
    │   Three parts. Find them all.                       │
    │   Decode them. Combine them.                        │
    │                                                     │
    │   SKILL ISSUE if you can't.                         │
    │                                                     │
    │   - Kevin                                           │
    │                                                     │
    └─────────────────────────────────────────────────────┘

EOF

# flag.txt (DECOY - TROLL)
cat > /root/kevin_farewell/flag.txt << 'EOF'
╔════════════════════════════════════════════╗
║                                            ║
║   FLAG: EXPLOIT3RS{just_kidding_lol}       ║
║                                            ║
║   Did you really think it would be here?   ║
║                                            ║
║   In a file called "flag.txt"?             ║
║                                            ║
║   Come on.                                 ║
║                                            ║
╚════════════════════════════════════════════╝
EOF

# real_flag.txt (DECOY - TROLL)
cat > /root/kevin_farewell/real_flag.txt << 'EOF'
Nice try.

The flag isn't called "real_flag" either.

Think harder.
EOF

# totally_not_flag.txt (DECOY)
cat > /root/kevin_farewell/totally_not_flag.txt << 'EOF'
This is totally not the flag.

Because reverse psychology doesn't work on CTF players.

Right?

...right?
EOF

# memories/first_day.txt (DECOY)
cat > /root/kevin_farewell/memories/first_day.txt << 'EOF'
First Day at Nimbus Technologies
================================

Dear Diary,

Today was my first day as an intern. The office has
free snacks and the wifi password is on a sticky note.

Everyone seems nice. The sysadmin showed me around.
He said I'd get "limited access" to the servers.

I'm sure that will be fine.

- Kevin
EOF

# memories/last_day.txt (DECOY)
cat > /root/kevin_farewell/memories/last_day.txt << 'EOF'
Last Day at Nimbus Technologies
===============================

Dear Diary,

They said "skill issue" was "unprofessional" and
"not appropriate for an all-hands email".

Whatever. I left them a present.

Let's see who has the skill issue now.

- Kevin
EOF

# memories/.the_truth.txt (DECOY)
cat > /root/kevin_farewell/memories/.the_truth.txt << 'EOF'
THE TRUTH
=========

The truth is...

...this file is also a decoy.

How many decoys are you going to read?
EOF

# .flag/part1.dat (REAL - ROT13 of "EXPLOIT3RS{sud0")
cat > /root/kevin_farewell/.flag/part1.dat << 'EOF'
RKCYBVG3EF{fhq0
EOF

# .flag/part2.dat (DECOY - base64)
cat > /root/kevin_farewell/.flag/part2.dat << 'EOF'
aGVoZSB5b3UgdGhvdWdodA==
EOF

# .flag/part3.dat (DECOY - hex)
cat > /root/kevin_farewell/.flag/part3.dat << 'EOF'
666c61677b6e6f705f7374696c6c5f6e6f747d
EOF

# .flag/.final (REAL - ROT13 of "_m1nus_0n3_g")
cat > /root/kevin_farewell/.flag/.final << 'EOF'
_z1ahf_0a3_t
EOF

# kevin_selfie.png (REAL - contains ROT13 part 3 in strings)
# ROT13 of "0t_m3_r00t}" is "0g_z3_e00g}"
echo -e '\x89PNG\r\n\x1a\n' > /root/kevin_farewell/kevin_selfie.png
head -c 200 /dev/urandom >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null || dd if=/dev/zero bs=200 count=1 >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null
echo '' >> /root/kevin_farewell/kevin_selfie.png
echo '0g_z3_e00g}' >> /root/kevin_farewell/kevin_selfie.png
echo '' >> /root/kevin_farewell/kevin_selfie.png
head -c 300 /dev/urandom >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null || dd if=/dev/zero bs=300 count=1 >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null
echo 'just some random data here nothing to see' >> /root/kevin_farewell/kevin_selfie.png
head -c 100 /dev/urandom >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null || dd if=/dev/zero bs=100 count=1 >> /root/kevin_farewell/kevin_selfie.png 2>/dev/null

# ignore_this/nothing_here.txt (DECOY)
cat > /root/kevin_farewell/ignore_this/nothing_here.txt << 'EOF'
There's nothing here.

I told you to ignore this folder.

Why don't people listen?
EOF

# ignore_this/seriously_nothing.txt (DECOY)
cat > /root/kevin_farewell/ignore_this/seriously_nothing.txt << 'EOF'
SERIOUSLY.

NOTHING.

HERE.

Go look in .flag/ or something.
Or check the selfie.
I don't know.

Stop reading decoys.
EOF

chmod 700 /root/kevin_farewell
chmod -R 600 /root/kevin_farewell/*
chmod 700 /root/kevin_farewell/memories
chmod 700 /root/kevin_farewell/.flag
chmod 700 /root/kevin_farewell/ignore_this

echo "[*] Challenge files created successfully!"
echo "[*] Flag: EXPLOIT3RS{sud0_m1nus_0n3_g0t_m3_r00t}"
echo "[*] (ROT13 encoded in 3 parts)"
