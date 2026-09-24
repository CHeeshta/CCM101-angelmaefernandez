#!/bin/bash
# =====================================================
# CCM101 Mission 10 - WordPress + MySQL Backup Script
# Author: Angel Fernandez
# Purpose: Backup WordPress DB + files with rotation
# =====================================================

set -e

BACKUP_DIR="$HOME/ccm101-mission10/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
RETENTION_DAYS=7
DB_CONTAINER="wp_db"
APP_CONTAINER="wp_app"
DB_USER="root"
DB_PASS="rootpass123"
DB_NAME="wordpress"

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting backup..."

# 1. Backup MySQL database
docker exec "$DB_CONTAINER" mysqldump \
    -u "$DB_USER" -p"$DB_PASS" \
    --single-transaction --no-tablespaces "$DB_NAME" \
    > "$BACKUP_DIR/wordpress_db_$DATE.sql"
echo "[$(date)] DB backup complete: wordpress_db_$DATE.sql"

# 2. Backup WordPress files (wp-content only)
docker exec "$APP_CONTAINER" tar -czf - /var/www/html/wp-content \
    > "$BACKUP_DIR/wordpress_files_$DATE.tar.gz"
echo "[$(date)] Files backup complete: wordpress_files_$DATE.tar.gz"

# 3. Rotate old backups
find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -delete
echo "[$(date)] Old backups cleaned (retention: $RETENTION_DAYS days)"

echo "[$(date)] Backup finished successfully."
echo "-------------------------------------------"
