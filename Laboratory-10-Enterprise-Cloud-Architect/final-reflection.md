# Final Reflection — Mission 10: The Enterprise Cloud Architect

**Author:** Angel Mae Fernandez
**Course:** CCM101 — Cloud Computing
**Instructor:** Jenkielyn C. Torres
**Date:** September 2026

---

## From Trainee to Architect

When I started CCM101, I barely knew what a Linux terminal was. Mission 1 ("Welcome to the Cloud") felt intimidating — every command was a guess and every error message was a wall. Ten missions later, I built a complete multi-tier cloud infrastructure from scratch and defended it live.

## What I Learned

### Technical Growth
- **Linux**: From basic navigation to writing Bash automation with error traps, logging, and pre-flight checks.
- **Docker**: I can now write a full docker-compose.yml with linked services, custom networks, healthchecks, and persistent volumes.
- **Security**: I understood UFW, default-deny policies, port management, and why the database should never be exposed to the host.
- **Automation**: I built a backup script that dumps MySQL, archives WordPress files, rotates old backups, and runs on a cron schedule.
- **WSL2 nuances**: Cron does not auto-start, secrets must be loaded explicitly, and Docker Desktop bridges networking between Windows and Linux.

### Architectural Thinking
- Diagramming matters — the architecture diagram was the blueprint for every decision.
- Isolation is a security feature: putting MySQL on an internal Docker network, not the host, is a deliberate design choice.
- Persistent storage is the difference between a demo and a production system.
- Documentation is not an afterthought — it is the product.

## Challenges I Overcame

1. **Port/name conflicts** — old containers fought with new deployments until I learned docker compose down --remove-orphans.
2. **Cron not firing in WSL2** — I discovered that the cron daemon does not start by default in WSL2 and had to enable it manually.
3. **Secrets management** — moving credentials out of the compose file into .env taught me about the real-world practice of keeping secrets out of version control.
4. **Backup validation** — an empty backup file is worse than no backup. Adding -s checks catches silent failures.

## What I Would Do Differently

- Use a real VM (KillerCoda / AWS Free Tier) during development, not just WSL2, so behaviors match the defense environment exactly.
- Implement log rotation and monitoring earlier, not as a final step.
- Add automated tests to verify the stack after every deployment.

## Final Thought

The mission brief said: "An Architect does not follow a manual; they write it." That single line describes my journey. I started CCM101 looking for step-by-step instructions. I finished it writing the manual for someone else to follow.

This project is proof that with curiosity, discipline, and the willingness to break things and fix them, anyone can go from passenger to pilot.

— **Angel Mae Fernandez**, Enterprise Cloud Architect
