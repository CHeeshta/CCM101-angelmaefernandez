# Enterprise Cloud Architect – Operational Manual

**CCM101 – Cloud Computing**
**Project: Secure Multi-Tier Web Application**
**Application Stack: WordPress + MySQL 8.0**
**Prepared by: Angel Crisedio Fernandez | Marlon DelMonte | John Henry Roldan | Ralph Lourene Micu**
**Section: BSIT 4I**
**Instructor: Jenkielyn C. Torres**
**Date: October 2026**

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Architecture Overview](#2-architecture-overview)
3. [Prerequisites](#3-prerequisites)
4. [Deployment Procedure](#4-deployment-procedure)
5. [Security Configuration](#5-security-configuration)
6. [Automation & Disaster Recovery](#6-automation--disaster-recovery)
7. [Verification & Testing](#7-verification--testing)
8. [Maintenance & Operations](#8-maintenance--operations)
9. [Troubleshooting Guide](#9-troubleshooting-guide)
10. [Appendix – Full Code Listings](#10-appendix--full-code-listings)

---

## 1. Executive Summary

This document serves as the operational handover manual for a secure, automated, multi-tier enterprise web application deployed on a private cloud environment.

The infrastructure consists of:

- A **headless Ubuntu Server 24.04 LTS** virtual machine running on Oracle VirtualBox
- **OpenSSH Server** for secure remote administration
- A **Docker + Docker Compose** container runtime
- A **WordPress** front-end web application container
- A **MySQL 8.0** database container with persistent storage volumes
- A **UFW firewall** enforcing a Default Deny inbound policy
- A **Bash + Cron automated backup system** for disaster recovery

The system is designed to be rebuilt from scratch on any Ubuntu Server host using only this document, the `docker-compose.yml`, and the `automation-script.sh`.

---

## 2. Architecture Overview

![Architecture Diagram](./architecture-diagram.png)

### Layer-by-Layer Description

**Layer 1 – Host Machine**
The physical laptop running Windows. It hosts the hypervisor and acts as the operator workstation.

**Layer 2 – Hypervisor (Oracle VirtualBox, Type 2)**
Provides VM isolation and NAT-based networking. Port forwarding is configured to expose the VM's services to the host:

| Host Port | Guest Port | Purpose |
|-----------|------------|---------|
| 2222 | 22 | SSH remote administration |
| 8080 | 8080 | WordPress HTTP access |

**Layer 3 – Guest VM (Ubuntu Server 24.04 LTS)**
A headless Linux server with the internal NAT IP `10.0.2.15`. It hosts the OpenSSH server, UFW firewall, and Docker engine.

**Layer 4 – Firewall (UFW)**
Enforces a Default Deny policy on inbound traffic, with explicit allow rules for SSH (22) and HTTP (8080).

**Layer 5 – Container Runtime (Docker Engine)**
Runs the application stack as two isolated containers on a private bridge network (`wp_net`).

**Layer 6 – Application Containers**

- `wordpress_app` – Apache + PHP 8.3 + WordPress (published on port 8080)
- `wordpress_db` – MySQL 8.0 (internal only, port 3306)

**Layer 7 – Persistent Storage (Docker Named Volumes)**

- `enterprise-app_db_data` – mounted at `/var/lib/mysql`
- `enterprise-app_wp_data` – mounted at `/var/www/html`

These volumes survive container removal and VM reboots.

### Data Flow

1. Operator opens `http://localhost:8080` in the host browser.
2. VirtualBox forwards host port 8080 to guest port 8080.
3. UFW allows the incoming connection to port 8080.
4. Docker routes the request to `wordpress_app` port 80 (internal container port).
5. WordPress queries `wordpress_db` on port 3306 via the internal bridge.
6. MySQL reads/writes to the persistent volume `db_data`.

### Remote Administration Flow

1. Operator opens PowerShell on the Windows host.
2. Runs `ssh -p 2222 angel@localhost`.
3. VirtualBox forwards host port 2222 to guest port 22.
4. UFW allows the incoming connection to port 22.
5. OpenSSH Server on the VM authenticates the user and grants a secure shell.

---

## 3. Prerequisites

### Hardware

- Laptop or desktop with 8 GB RAM minimum (4 GB allocated to VM)
- 30 GB free disk space
- Stable internet connection

### Software

- Oracle VirtualBox (latest)
- Ubuntu Server 24.04 LTS ISO
- A modern web browser
- (Windows only) PowerShell for SSH

### Knowledge

- Basic Linux command line
- Basic Docker concepts
- Basic networking (IP, ports, NAT)
- Basic SSH usage

---

## 4. Deployment Procedure

### Step 1 — Provision the VM

1. Open VirtualBox → **New**
2. Name: `CCM101-Enterprise-Architect`
3. Type: Linux / Version: Ubuntu (64-bit)
4. RAM: 2048 MB minimum (4096 recommended)
5. Disk: 20 GB dynamically allocated VDI
6. Mount the Ubuntu Server ISO and boot the VM
7. In the installer:
   - Set hostname: `CCM101-Enterprise-Architect`
   - Create user `angel` with a strong password
   - **Enable OpenSSH Server** during install ← **REQUIRED**
   - Skip featured snaps

### Step 2 — Configure Networking

1. Shut down the VM
2. Settings → Network → Adapter 1
3. Attached to: **NAT**
4. Advanced → Port Forwarding → Add:

   | Name | Protocol | Host IP | Host Port | Guest IP | Guest Port |
   |------|----------|---------|-----------|----------|------------|
   | SSH | TCP | (blank) | 2222 | (blank) | 22 |
   | HTTP | TCP | (blank) | 8080 | (blank) | 8080 |

5. Start the VM, log in, and confirm IP:

   ```bash
   hostname -I
   ```

   Expected: `10.0.2.15`

> **Why guest port 8080 for HTTP?** Docker publishes the WordPress container on VM port 8080 (`"8080:80"` in `docker-compose.yml`). VirtualBox must forward host 8080 → guest 8080 so the request reaches the Docker-published port.

### Step 3 — Install OpenSSH Server (If Not Enabled During Install)

Log into the VM via the VirtualBox console and run:

```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh
sudo ss -tlnp | grep :22
sudo ufw allow 22/tcp comment 'SSH'
```

### Step 4 — Test SSH from Windows Host

Open **PowerShell** on your Windows host:

```powershell
ssh -p 2222 angel@localhost
```

Enter the password created during Ubuntu installation. You should be logged in:

```
angel@CCM101-Enterprise-Architect:~$
```

> **Tip:** To avoid typing the port every time, create `C:\Users\<YourName>\.ssh\config`:

```ssh-config
Host ccm101
    HostName localhost
    Port 2222
    User angel
```

Then simply run `ssh ccm101`.

### Step 5 — Install Docker & Docker Compose

Run inside the VM:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose-v2
sudo usermod -aG docker $USER
newgrp docker
docker --version
docker compose version
```

### Step 6 — Create the Project Directory

```bash
mkdir -p ~/enterprise-app && cd ~/enterprise-app
```

### Step 7 — Create `docker-compose.yml`

Create the file with the contents in [Appendix A](#appendix-a--docker-composeyml).

### Step 8 — Create `init.sql`

```bash
cat > init.sql << 'EOF'
ALTER USER 'wpuser'@'%' IDENTIFIED WITH mysql_native_password BY 'SuperWpPass123!';
FLUSH PRIVILEGES;
EOF
```

### Step 9 — Deploy the Stack

```bash
docker compose up -d
docker compose ps
```

Wait 60–90 seconds for MySQL to initialize. Then open `http://localhost:8080` on the host browser and complete the WordPress setup wizard.

---

## 5. Security Configuration

### UFW (Uncomplicated Firewall)

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 8080/tcp comment 'WordPress App'
sudo ufw --force enable
sudo ufw status verbose
```

### Expected Output

```
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                   # SSH
8080/tcp                   ALLOW IN    Anywhere                   # WordPress App
```

### OpenSSH Hardening (Recommended)

Edit the SSH config:

```bash
sudo nano /etc/ssh/sshd_config
```

Recommended changes:

```
PermitRootLogin no
PasswordAuthentication yes
PubkeyAuthentication yes
MaxAuthTries 3
LoginGraceTime 30
```

Restart SSH:

```bash
sudo systemctl restart ssh
```

### SSH Key-Based Authentication

#### 5.1 — Generate a New SSH Key (Windows Host)

If you need a new SSH key pair, run this on the **Windows host** in PowerShell:

```powershell
ssh-keygen -t ed25519 -C "angel@localhost"
```

Press **Enter** through the prompts (accept default path, optionally set a passphrase).

This creates:

| File | Purpose |
|------|---------|
| `C:\Users\<YourName>\.ssh\id_ed25519` | Private key (never share) |
| `C:\Users\<YourName>\.ssh\id_ed25519.pub` | Public key (copied to server) |

#### 5.2 — Copy the Public Key to the VM

```powershell
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh -p 2222 angel@localhost "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```

#### 5.3 — Test Key-Based Login

```powershell
ssh -p 2222 angel@localhost
```

If the key was installed correctly, you will be logged in **without** being prompted for the account password.

#### 5.4 — Disable Password Authentication (After Key Works)

Inside the VM, edit `/etc/ssh/sshd_config`:

```
PasswordAuthentication no
PubkeyAuthentication yes
```

Restart SSH:

```bash
sudo systemctl restart ssh
```

### Security Principles Applied

- **Default Deny** — no unsolicited inbound connection reaches the VM
- **Least Privilege** — only ports 22 and 8080 are open
- **Database Isolation** — MySQL port 3306 is NOT exposed to the host; it is only reachable inside the `wp_net` Docker bridge network
- **Volume Isolation** — persistent data lives in Docker volumes, not bind mounts
- **Separate Credentials** — root DB password and application DB password are distinct
- **SSH Key Authentication** — eliminates password brute-force attacks
- **Root Login Disabled** — prevents direct root access over SSH

---

## 6. Automation & Disaster Recovery

### Backup Script

Located at `/home/angel/enterprise-app/backup.sh` — see [Appendix B](#appendix-b--automation-scriptsh).

It:

1. Dumps all MySQL databases from the `wordpress_db` container
2. Compresses the dump with gzip
3. Stores it in `~/enterprise-app/backups/`
4. Logs the result to `backup.log`
5. Retains only the most recent 7 daily backups

### Cron Schedule

```cron
0 2 * * * /home/angel/enterprise-app/backup.sh >> /home/angel/enterprise-app/cron.log 2>&1
```

The backup runs **every day at 02:00**.

To edit the crontab:

```bash
crontab -e
```

### Restore Procedure

```bash
cd ~/enterprise-app/backups
ls -lt   # find the newest .sql.gz

gunzip -c wordpress_db_YYYYMMDD_HHMMSS.sql.gz | \
  docker exec -i wordpress_db mysql -uroot -pSuperRootPass123!
```

---

## 7. Verification & Testing

### Container Status

```bash
docker compose ps
```

Both `wordpress_app` and `wordpress_db` should show `Up`.

### Volume Persistence

```bash
docker compose down
docker compose up -d
```

After restart, WordPress site and admin credentials remain intact — proving the named volumes work.

### Volume Listing

```bash
docker volume ls
```

Should show `enterprise-app_db_data` and `enterprise-app_wp_data`.

### Firewall Status

```bash
sudo ufw status verbose
```

### SSH Service Status

```bash
sudo systemctl status ssh
sudo ss -tlnp | grep :22
```

### Backup Verification

```bash
ls -lh ~/enterprise-app/backups/
cat ~/enterprise-app/backup.log
```

### Remote Access (SSH)

```powershell
ssh -p 2222 angel@localhost
```

### Browser Access

```
http://localhost:8080            → live WordPress site
http://localhost:8080/wp-admin/  → admin dashboard
```

---

## 8. Maintenance & Operations

### Daily

- Cron automatically runs the DB backup at 02:00
- Verify SSH access still works: `ssh -p 2222 angel@localhost`

### Weekly

- Verify backup files exist: `ls -lh ~/enterprise-app/backups/`
- Review backup log: `tail -20 ~/enterprise-app/backup.log`
- Check UFW status: `sudo ufw status verbose`
- Check SSH service: `sudo systemctl status ssh`

### Monthly

- Update Ubuntu packages:

  ```bash
  sudo apt update && sudo apt upgrade -y
  ```

- Update Docker images:

  ```bash
  cd ~/enterprise-app
  docker compose pull
  docker compose up -d
  ```

- Review SSH auth logs for suspicious activity:

  ```bash
  sudo journalctl -u ssh --since "1 month ago" | grep "Failed password"
  ```

### On Failure

- Check logs: `docker compose logs --tail 50`
- Restart: `docker compose restart`
- Check SSH: `sudo systemctl restart ssh`
- Full rebuild from backup (see Section 6)

---

## 9. Troubleshooting Guide

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| `hostname -I` blank | Bridged adapter can't bridge to Wi-Fi | Switch VirtualBox to NAT |
| `Connection refused` on SSH | Port forwarding guest port wrong | Guest port must be 22, host port 2222 |
| `Connection refused` on SSH (forwarding OK) | OpenSSH not installed or not running | `sudo apt install -y openssh-server && sudo systemctl enable --now ssh` |
| `Connection timed out` on SSH | UFW blocking port 22 | `sudo ufw allow 22/tcp` |
| `Permission denied (publickey)` | SSH key not installed on server | Generate new key with `ssh-keygen -t ed25519 -C "angel@localhost"`, then copy `.pub` to VM |
| `REMOTE HOST IDENTIFICATION HAS CHANGED!` | VM host key changed (clone, reinstall) | `ssh-keygen -R "[localhost]:2222"` on Windows host, then reconnect and type `yes` |
| SSH service not running | OpenSSH not installed or stopped | `sudo apt install openssh-server && sudo systemctl enable --now ssh` |
| `sshd -t` reports syntax error | Bad `sshd_config` edit | Restore from backup or fix the offending line |
| "Error establishing a database connection" | MySQL 8 `caching_sha2_password` | Apply `init.sql` with `mysql_native_password` |
| Access denied for `wpuser@localhost` | Testing from inside DB container | Use `-h 127.0.0.1` or `-uroot` |
| Docker Compose `version` warning | Obsolete compose syntax | Remove the `version: '3.8'` line |
| Port 8080 not reachable | UFW blocking | `sudo ufw allow 8080/tcp` |
| Port 8080 not reachable (UFW OK) | VirtualBox port forwarding guest port wrong | Guest port must be **8080**, host port 8080 |
| Backup file empty (0 bytes) | `docker exec` failed | Verify container name with `docker ps` |

---

## 10. Appendix – Full Code Listings

### Appendix A – `docker-compose.yml`

```yaml
services:
  db:
    image: mysql:8.0
    container_name: wordpress_db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: SuperRootPass123!
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: SuperWpPass123!
    volumes:
      - db_data:/var/lib/mysql
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    networks:
      - wp_net

  wordpress:
    image: wordpress:latest
    container_name: wordpress_app
    restart: unless-stopped
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: SuperWpPass123!
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp_data:/var/www/html
    depends_on:
      - db
    networks:
      - wp_net

volumes:
  db_data:
  wp_data:

networks:
  wp_net:
    driver: bridge
```

### Appendix B – `automation-script.sh`

```bash
#!/bin/bash
BACKUP_DIR="/home/angel/enterprise-app/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="wordpress_db_${TIMESTAMP}.sql.gz"
LOG_FILE="/home/angel/enterprise-app/backup.log"

mkdir -p "$BACKUP_DIR"

docker exec wordpress_db sh -c \
  'exec mysqldump --all-databases -uroot -pSuperRootPass123!' \
  | gzip > "$BACKUP_DIR/$FILENAME"

if [ -f "$BACKUP_DIR/$FILENAME" ]; then
  echo "[$(date)] SUCCESS: $FILENAME ($(du -h "$BACKUP_DIR/$FILENAME" | cut -f1))" >> "$LOG_FILE"
else
  echo "[$(date)] FAILED: Backup was not created" >> "$LOG_FILE"
fi

find "$BACKUP_DIR" -type f -name "wordpress_db_*.sql.gz" -mtime +7 -delete
exit 0
```

Make it executable:

```bash
chmod +x /home/angel/enterprise-app/automation-script.sh
```

### Appendix C – `init.sql`

```sql
ALTER USER 'wpuser'@'%' IDENTIFIED WITH mysql_native_password BY 'SuperWpPass123!';
FLUSH PRIVILEGES;
```

### Appendix D – OpenSSH Installation Script

```bash
#!/bin/bash
# OpenSSH Server Installation & Configuration
# Run with: sudo bash install-openssh.sh

set -e

echo "[+] Updating package lists..."
sudo apt update

echo "[+] Installing OpenSSH Server..."
sudo apt install -y openssh-server

echo "[+] Enabling SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo "[+] Allowing SSH through UFW..."
sudo ufw allow 22/tcp comment 'SSH'

echo "[+] Verifying SSH service status..."
sudo systemctl status ssh --no-pager

echo "[+] Checking SSH listening port..."
sudo ss -tlnp | grep :22

echo "[+] Validating sshd_config syntax..."
sudo sshd -t && echo "sshd_config OK"

echo "[+] OpenSSH installation complete."
echo "[+] Test from Windows host with: ssh -p 2222 angel@localhost"
```

Make it executable and run:

```bash
chmod +x install-openssh.sh
sudo bash install-openssh.sh
```

### Appendix E – Generate a New SSH Key (Windows Host)

```powershell
# Generate a new Ed25519 key pair
ssh-keygen -t ed25519 -C "angel@localhost"

# Copy the public key to the VM
type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh -p 2222 angel@localhost "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

# Test key-based login
ssh -p 2222 angel@localhost
```

> **If you see `REMOTE HOST IDENTIFICATION HAS CHANGED!`**, run this first:
>
> ```powershell
> ssh-keygen -R "[localhost]:2222"
> ```
>
> Then reconnect and type `yes` to accept the new host key.

### Appendix F – SSH Config (`~/.ssh/config` on Windows Host)

```ssh-config
Host ccm101
    HostName localhost
    Port 2222
    User angel
    IdentityFile ~/.ssh/id_ed25519
```

### Appendix G – SSH Hardening (`/etc/ssh/sshd_config`)

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
LoginGraceTime 30
X11Forwarding no
AllowTcpForwarding yes
```

### Appendix H – VirtualBox Port Forwarding Summary

| Name | Protocol | Host IP | Host Port | Guest IP | Guest Port |
|------|----------|---------|-----------|----------|------------|
| SSH | TCP | (blank) | 2222 | (blank) | 22 |
| HTTP | TCP | (blank) | 8080 | (blank) | 8080 |

> **Important:** The HTTP guest port must be **8080** (not 80) because Docker publishes the WordPress container on VM port 8080 via the `"8080:80"` mapping in `docker-compose.yml`.

---

*End of Operational Manual*
