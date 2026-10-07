# Laboratory 10 – Enterprise Cloud Architect

## Mission Overview

Design, deploy, secure, automate, and document a complete production-ready enterprise infrastructure from scratch.

## Application Stack

- Web Application: WordPress (latest)
- Database: MySQL 8.0
- Runtime: Docker + Docker Compose
- Host OS: Ubuntu Server 24.04 LTS
- Hypervisor: Oracle VirtualBox (Type 2)

## Architecture

![Architecture Diagram](./architecture-diagram.png)

## Quick Reference

| Item | Value |
|------|-------|
| VM IP (NAT) | 10.0.2.15 |
| SSH | ssh -p 2222 angel@localhost |
| Web app | http://localhost:8080 |
| Firewall | UFW - default deny incoming |
| Backup | Daily cron at 02:00 |
| Volumes | db_data, wp_data |

## Files In This Folder

- README.md - this file
- architecture-diagram.png - network topology diagram
- docker-compose.yml - container stack definition
- automation-script.sh - Bash backup script
- init.sql - MySQL init script
- operational-manual.md - full handover manual
- final-reflection.md - Mission 1 to 10 reflection
