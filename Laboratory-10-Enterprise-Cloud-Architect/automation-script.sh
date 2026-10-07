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
  echo "[$(date)] FAILED" >> "$LOG_FILE"
fi

find "$BACKUP_DIR" -type f -name "wordpress_db_*.sql.gz" -mtime +7 -delete
exit 0
