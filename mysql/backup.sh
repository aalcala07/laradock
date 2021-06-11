#!/bin/bash
DATE=`date +%Y%m%d_%H%M%S`

xtrabackup --defaults-extra-file=/etc/mysql/conf.d/my.cnf --backup --stream=xbstream --compress | aws s3 cp - s3://$MYSQL_BACKUP_S3_BUCKET/$DATE-lcmp.xbstream

# Restore

# 1. MKDIR in /data/backups and CD into that directory
# 2. Download backup from S3
# 3. Use "xbstream -x < lcmp.xbstream" to unpack in current directory
# 4. Prepare with xtrabackup
# 5. Exit and stop container
# 6. Delete mysql files from host
# 7. Run xtrabackup on host to copy files over to mysql. Make sure permissions are right.
# 8. Start MySQL container


# Crontab - Run at 3AM CDT every day
# 0 8 * * * cd /home/ubuntu/lcmp/docker && /usr/local/bin/docker-compose exec -T mysql bash backup.sh

