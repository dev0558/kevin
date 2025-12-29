# The Farewell Gift

```
  ███╗   ██╗██╗███╗   ███╗██████╗ ██╗   ██╗███████╗
  ████╗  ██║██║████╗ ████║██╔══██╗██║   ██║██╔════╝
  ██╔██╗ ██║██║██╔████╔██║██████╔╝██║   ██║███████╗
  ██║╚██╗██║██║██║╚██╔╝██║██╔══██╗██║   ██║╚════██║
  ██║ ╚████║██║██║ ╚═╝ ██║██████╔╝╚██████╔╝███████║
  ╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═════╝  ╚═════╝ ╚══════╝
                                   TECHNOLOGIES
```

**A Privilege Escalation CTF Challenge by Exploit3rs Cyber Security Academy**

---

## Challenge Overview

| Property | Value |
|----------|-------|
| **Name** | The Farewell Gift |
| **Category** | Privilege Escalation |
| **Difficulty** | Easy |
| **CVE** | CVE-2021-4034 (PwnKit) |
| **Flag Format** | `EXPLOIT3RS{...}` |

### Backstory

A disgruntled ex-intern named "Kevin" was terminated from Nimbus Technologies after he mass-replied "skill issue" to an executive email thread. Before leaving, he scattered clues across the server and hid a "farewell gift" that only root can access.

Your mission: Escalate privileges and find Kevin's gift.

---

## Quick Start

### Prerequisites

- Docker (20.10+)
- Docker Compose (2.0+)

### Deployment

```bash
# Clone the repository
git clone <repository-url>
cd the-farewell-gift

# Build and start the challenge
docker-compose up -d --build

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

### Access

| Service | URL |
|---------|-----|
| Landing Page | http://localhost:8080 |
| Direct Terminal | http://localhost:7681 |

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Docker Container                         │
│  ┌─────────────────┐        ┌─────────────────────────────┐ │
│  │                 │        │                             │ │
│  │  nginx (:80)    │───────▶│  Landing Page (HTML/CSS/JS) │ │
│  │                 │        │  - CRT terminal aesthetic   │ │
│  │  /terminal/ ────┼───────▶│  - Boot sequence animation  │ │
│  │                 │        │  - Matrix rain background   │ │
│  └────────┬────────┘        └─────────────────────────────┘ │
│           │                                                  │
│           ▼                                                  │
│  ┌─────────────────┐                                        │
│  │                 │                                        │
│  │  ttyd (:7681)   │──────▶ Web Terminal as kevin-debug     │
│  │                 │        - Vulnerable polkit (pkexec)    │
│  └─────────────────┘        - Challenge files scattered     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Challenge Files

```
/home/kevin-debug/
├── README.txt          # Starting point with hints
├── .bash_history       # Kevin's command history
└── notes/
    └── todo.txt        # Kevin's todo list

/opt/nimbus/
├── .kevin_was_here     # Hidden file (needs ls -la)
└── logs/
    └── debug.log       # Important hint about pkexec

/var/backups/kevin_stuff/
├── memes/
│   └── skill_issue.txt # Red herring
└── .secret_note.txt    # Key hint about CVE

/tmp/.k3v1n/            # Hidden directory
└── hints.txt           # Final hint (CVE-2021-XXXX)

/root/kevin_farewell/   # Only accessible as root!
├── goodbye.txt         # Kevin's farewell message
└── flag.txt            # THE FLAG
```

---

## Administration

### Reset Challenge

```bash
# Full reset
docker-compose down -v && docker-compose up -d --build

# Quick restart
docker-compose restart
```

### Shell Access (for debugging)

```bash
# As kevin-debug
docker exec -it kevin-farewell-gift /bin/bash -c "su - kevin-debug"

# As root
docker exec -it kevin-farewell-gift /bin/bash
```

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker logs kevin-farewell-gift -f
```

### Stop Challenge

```bash
docker-compose down
```

---

## Customization

### Change the Flag

Edit `setup/create-files.sh` and modify the flag in `/root/kevin_farewell/flag.txt`:

```bash
# Find and replace the flag
EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}
```

### Change Ports

Edit `docker-compose.yml`:

```yaml
ports:
  - "YOUR_PORT:80"     # Landing page
  - "YOUR_PORT:7681"   # Terminal (if needed)
```

### Modify Landing Page

Edit files in the `web/` directory:
- `index.html` - Content and structure
- `style.css` - Styling and effects
- `script.js` - Boot animation and effects

---

## Security Considerations

This challenge intentionally contains a vulnerable version of Polkit (CVE-2021-4034).

**Do NOT run this in production or on sensitive systems.**

Recommended practices:
- Run in isolated Docker network
- Use resource limits (already configured)
- Reset frequently in multi-user environments
- Monitor for abuse

---

## Troubleshooting

### Terminal not connecting

```bash
# Check if ttyd is running
docker exec kevin-farewell-gift ps aux | grep ttyd

# Check ttyd logs
docker exec kevin-farewell-gift cat /var/log/ttyd/error.log
```

### Landing page not loading

```bash
# Check nginx status
docker exec kevin-farewell-gift nginx -t

# Check nginx logs
docker exec kevin-farewell-gift cat /var/log/nginx/error.log
```

### PwnKit not working

Ensure the container has proper permissions:

```bash
# Check pkexec SUID bit
docker exec kevin-farewell-gift ls -la /usr/bin/pkexec

# Should show: -rwsr-xr-x (note the 's')
```

---

## Credits

- **Challenge Design**: Exploit3rs Cyber Security Academy
- **CVE Reference**: CVE-2021-4034 (PwnKit) by Qualys Research Team
- **UI Inspiration**: Mr. Robot, Fallout terminals, classic CRT aesthetics

---

## License

This challenge is provided for educational purposes only. Use responsibly.

```
"skill issue" - Kevin, 2024
```
