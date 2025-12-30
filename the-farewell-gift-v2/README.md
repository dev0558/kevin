# The Farewell Gift v2 - Hard Mode

```
  ███╗   ██╗██╗███╗   ███╗██████╗ ██╗   ██╗███████╗
  ████╗  ██║██║████╗ ████║██╔══██╗██║   ██║██╔════╝
  ██╔██╗ ██║██║██╔████╔██║██████╔╝██║   ██║███████╗
  ██║╚██╗██║██║██║╚██╔╝██║██╔══██╗██║   ██║╚════██║
  ██║ ╚████║██║██║ ╚═╝ ██║██████╔╝╚██████╔╝███████║
  ╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝ ╚══════╝
                                   TECHNOLOGIES
```

**A Privilege Escalation CTF Challenge - Hard Mode**
**Exploit3rs Cyber Security Academy**

---

## Challenge Overview

| Property | Value |
|----------|-------|
| **Name** | The Farewell Gift v2 |
| **Category** | Privilege Escalation |
| **Difficulty** | Medium-Hard |
| **Vulnerability** | Sudo User ID Bypass |
| **Flag Format** | `EXPLOIT3RS{...}` |

### Design Philosophy

- **No direct hints** - Players must think and research
- **Multiple decoy files** - 30+ fake files to waste time
- **Subtle clues only** - Hidden in logs, notes, memes
- **Multi-step flag** - ROT13 encoded, split across 3 files
- **No hand-holding** - Figure it out or give up

---

## Quick Start

```bash
# Build and run
docker-compose up -d --build

# Access
open http://localhost:8080
```

---

## Challenge Structure

### Clue Locations (Subtle)
- `/opt/nimbus/logs/debug.log` - Mentions "negative values" and "UID resolution"
- `/var/backups/kevin_stuff/.secret_note.txt` - Talks about numbers and wraparound
- `/var/backups/kevin_stuff/memes/sudo_meme.txt` - "What if user ID goes brrr?"
- `/tmp/.k3v1n/thoughts.txt` - Mentions -1 becoming 0

### Decoy Locations (Many)
- `/home/kevin-debug/notes/` - Fake passwords, useless notes
- `/home/kevin-debug/scripts/` - Useless scripts
- `/home/kevin-debug/.secret/` - Troll message
- `/opt/nimbus/config/` - Fake configs
- `/opt/nimbus/data/` - Fake database, fake backup
- `/root/kevin_farewell/flag.txt` - FAKE flag
- `/root/kevin_farewell/real_flag.txt` - Also FAKE
- And many more...

### Flag Location
Split into 3 ROT13-encoded parts:
1. `/root/kevin_farewell/.flag/part1.dat`
2. `/root/kevin_farewell/.flag/.final`
3. `/root/kevin_farewell/kevin_selfie.png` (via `strings`)

---

## Administration

### Reset
```bash
docker-compose down -v && docker-compose up -d --build
```

### Debug Access
```bash
# As kevin-debug
docker exec -it kevin-farewell-gift-v2 su - kevin-debug

# As root
docker exec -it kevin-farewell-gift-v2 bash
```

---

## Credits

- **Challenge Design**: Exploit3rs Cyber Security Academy
- **Vulnerability**: CVE-2019-14287 (not mentioned in challenge)

---

```
"Figure it out." - Kevin
```
