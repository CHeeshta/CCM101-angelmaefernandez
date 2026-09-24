# Enterprise Cloud Architect — Operational Manual

**Project:** Secure Multi-Tier Web Application
**Application Stack:** WordPress + MySQL
**Prepared by:** Angel Mae Fernandez
**Section:** BSIT
**Instructor:** Jenkielyn C. Torres
**Date:** September 2026

---

## 1. Architecture Overview

- **Windows Host** (laptop)
- **WSL2 Ubuntu 24.04** (Linux VM)
- **Docker Engine** (container runtime)
- **UFW Firewall** (host hardening)
- **wp_app** — WordPress (Apache + PHP) — Port 8080
- **wp_db** — MySQL 8.0 — Port 3306 (internal only)
- **Volumes:** `wp_data`, `db_data`
- **Network:** `wp_net` (bridge)

## 2. Deployment Procedure

### Prerequisites
- Windows 10/11 with WSL2 enabled
- Docker Desktop with WSL2 integration ON
- Ubuntu 24.04 WSL distro

### Deploy
```bash
cd ~/ccm101-mission10
docker compose up -d
docker compose ps
