# Enterprise Cloud Architect — Operational Manual

**Project:** Secure Multi-Tier Web Application
**Application Stack:** WordPress + MySQL
**Prepared by:** Angel Mae Fernandez
**Section:** BSIT
**Instructor:** Jenkielyn C. Torres
**Date:** September 2026

---

## 1. Architecture Overview

| Layer | Component | Purpose |
|---|---|---|
| Physical | Windows Host Laptop | User workstation |
| Virtualization | WSL2 (Ubuntu 24.04) | Headless Linux VM |
| Container Runtime | Docker Engine + Compose | Runs containers |
| Firewall | UFW | Host-based network hardening |
| App Tier | wp_app (WordPress + Apache + PHP) | Serves website on port 8080 |
| Data Tier | wp_db (MySQL 8.0) | Stores WordPress data, internal port 3306 |
| Storage | wp_data, db_data (Docker volumes) | Persistent storage |
| Network | wp_net (bridge) | Isolated network between containers |

**Data flow:** User browser -> Windows host -> WSL2 Ubuntu (UFW) -> Docker Engine (wp_net) -> wp_app -> wp_db

---

## 2. Deployment Procedure

### 2.1 Prerequisites
- Windows 10/11 with WSL2 enabled
- Docker Desktop with WSL2 integration ON
- Ubuntu 24.04 WSL distribution
- Git installed in WSL2

### 2.2 Clone the repository
Open your WSL2 Ubuntu terminal and run:

    git clone https://github.com/CHeeshta/CCM101-angelmaefernandez.git
    cd CCM101-angelmaefernandez/Laboratory-10-Enterprise-Cloud-Architect

### 2.3 Configure environment variables
Copy the example file and edit it with your own values:

    cp .env.example .env
    nano .env

Required variables:
- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE (default: wordpress)
- MYSQL_USER (default: wpuser)
- MYSQL_PASSWORD

### 2.4 Start the stack

    docker compose up -d

### 2.5 Verify

    docker compose ps

Expected:
- wp_db — Up (healthy)
- wp_app — Up — 0.0.0.0:8080->80/tcp

### 2.6 Access the application
Open http://localhost:8080 in the Windows host browser.

---

## 3. Security Configuration

### 3.1 UFW (Firewall)

    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp
    sudo ufw allow 8080/tcp
    sudo ufw enable
    sudo ufw status verbose

Expected output:
- Status: active
- Default: deny (incoming), allow (outgoing), deny (routed)
- 22/tcp ALLOW IN Anywhere
- 8080/tcp ALLOW IN Anywhere

### 3.2 Database isolation
- MySQL port 3306 is NOT published to the host.
- Reachable only inside the wp_net bridge network.
- WordPress connects via internal DNS name db:3306.

### 3.3 Secret management
- Credentials stored in .env (never committed).
- .env.example committed with placeholders.
- Production: use Docker Secrets / Vault / cloud KMS.

### 3.4 Hardening checklist
- UFW enabled, default-deny inbound
- Only 22 and 8080 exposed
- DB not reachable externally
- Secrets out of version control
- restart: unless-stopped on both containers
- MySQL healthcheck before app starts

---

## 4. Maintenance & Operations

### 4.1 Automated backups
Script automation-script.sh performs:
1. mysqldump of WordPress DB
2. tar.gz archive of wp-content
3. Rotation — deletes backups older than 7 days

Run manually:

    export MYSQL_ROOT_PASSWORD=<root_password>
    ./automation-script.sh

Backups written to ~/ccm101-mission10/backups/.

### 4.2 Scheduled backups (cron)
Daily at 02:00 via cron:

    0 2 * * * MYSQL_ROOT_PASSWORD=<root_password> BACKUP_DIR=/home/angel/ccm101-mission10/backups /home/angel/CCM101-angelmaefernandez/Laboratory-10-Enterprise-Cloud-Architect/automation-script.sh >> /home/angel/ccm101-mission10/backups/cron.log 2>&1

WSL2 note: cron does NOT auto-start. Run after each reboot:

    sudo service cron start

### 4.3 Restore procedure
Database:

    docker exec -i wp_db mysql -u root -p"$MYSQL_ROOT_PASSWORD" wordpress < backups/wordpress_db_<timestamp>.sql

Files:

    docker exec -i wp_app tar -xzf - -C /var/www/html < backups/wordpress_files_<timestamp>.tar.gz

### 4.4 Common operations

| Task | Command |
|---|---|
| View containers | docker compose ps |
| View logs | docker compose logs -f |
| Restart | docker compose restart |
| Stop (keep data) | docker compose down |
| Stop + wipe data | docker compose down -v |
| Shell into DB | docker exec -it wp_db bash |
| Shell into app | docker exec -it wp_app bash |

### 4.5 Disaster recovery
1. Re-clone repo on a fresh Ubuntu host
2. Recreate .env with same credentials
3. Run docker compose up -d
4. Restore latest DB dump + file archive
5. Verify site loads at http://<host>:8080

---

## 5. Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Container name already in use | Old container lingering | docker compose down --remove-orphans |
| wp_db stuck starting | MySQL initializing | Wait 30-60s |
| Site not reachable | UFW or stack down | Check ufw status + docker compose ps |
| Cron not running | WSL2 cron stopped | sudo service cron start |
| Empty backup | Container down during run | Check backup.log |

---

## 6. Repository Layout

    CCM101-angelmaefernandez/
    └── Laboratory-10-Enterprise-Cloud-Architect/
        ├── README.md
        ├── architecture-diagram.png
        ├── docker-compose.yml
        ├── automation-script.sh
        ├── operational-manual.md
        └── final-reflection.md

---

## 7. Change Log

| Date | Change | Author |
|---|---|---|
| Sep 24, 2026 | Initial deployment, hardening, backup automation | Angel Mae Fernandez |
