# Laboratory 10 — Enterprise Cloud Architect

**Course:** CCM101 — Cloud Computing
**Instructor:** Jenkielyn C. Torres
**Author:** Angel Mae Fernandez
**Date:** September 2026

---

## Project Overview

A production-ready, multi-tier containerized application deployed on Ubuntu (WSL2) using Docker. The stack consists of **WordPress** (front-end/CMS) and **MySQL 8.0** (database), secured with UFW and automated with a custom Bash backup script scheduled via cron.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Host OS | Windows + WSL2 (Ubuntu 24.04) |
| Container Runtime | Docker Desktop + Docker Engine 29.x |
| Orchestration | Docker Compose v5.x |
| Application | WordPress (latest) |
| Database | MySQL 8.0 |
| Security | UFW (Default Deny) |
| Automation | Bash + Cron |

## Quick Deploy

```bash
docker compose up -d
docker compose ps
