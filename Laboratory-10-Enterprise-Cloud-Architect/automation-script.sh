#!/bin/bash
# =====================================================
# CCM101 Mission 10 - WordPress + MySQL Backup Script
# Author: Angel Fernandez
# Purpose: Backup WordPress DB + files with rotation
# =====================================================

set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-$HOME/ccm101-mission10/backups}"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
RETENTION_DAYS=7
DB_CONTAINER="wp_db"
APP_CONTAINER="wp_app"
DB_NAME="${MYSQL_DATABASE:-wordpress}"
LOG_FILE="$BACKUP_DIR/backup.log"

DB_PASS="${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is not set}"

mkdir -p "$BACKUP_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1
trap 'echo "[$(date)] ERROR: Backup failed at line $LINENO"' ERR

echo "==========================================="
echo "[$(date)] Starting backup..."

if ! docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER}$"; then
    echo "[$(date)] ERROR: Container $DB_CONTAINER is not running. Aborting."
    exit 1
fi
if ! docker ps --format '{{.Names}}' | grep -q "^${APP_CONTAINER}$"; then
    echo "[$(date)] ERROR: Container $APP_CONTAINER is not running. Aborting."
    exit 1
fi

DB_BACKUP="$BACKUP_DIR/wordpress_db_$DATE.sql"
docker exec "$DB_CONTAINER" sh -c \
    'exec mysqldump -u root -p"$MYSQL_ROOT_PASSWORD" --single-transaction --no-tablespaces "$MYSQL_DATABASE"' \
    > "$DB_BACKUP"

if [ ! -s "$DB_BACKUP" ]; then
    echo "[$(date)] ERROR: DB backup file is empty. Aborting."
    exit 1
fi
echo "[$(date)] DB backup complete: $(basename "$DB_BACKUP")"

FILES_BACKUP="$BACKUP_DIR/wordpress_files_$DATE.tar.gz"
docker exec "$APP_CONTAINER" tar -czf - /var/www/html/wp-content > "$FILES_BACKUP"

if [ ! -s "$FILES_BACKUP" ]; then
    echo "[$(date)] ERROR: Files backup is empty. Aborting."
    exit 1
fi
echo "[$(date)] Files backup complete: $(basename "$FILES_BACKUP")"

DELETED=$(find "$BACKUP_DIR" -type f \( -name "*.sql" -o -name "*.tar.gz" \) -mtime +$RETENTION_DAYS -print -delete | wc -l)
echo "[$(date)] Old backups cleaned: $DELETED file(s) removed (retention: $RETENTION_DAYS days)"

echo "[$(date)] Backup finished successfully."
echo "==========================================="
