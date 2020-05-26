#!/bin/bash
# Description:
# 1) AWS_ACCESS_KEY_ID, AWS_DEFAULT_REGION and AWS_SECRET_ACCESS_KEY are set globally to jenkins instance
# 2) MYSQL_ROOT_PASSWORD, MYSQL_HOST, MYSQL_DB, AWS_BUCKET are parameters passed to the jenkins job

set -e -v

printf "Starting taking the backup\n"

MYSQL_ROOT_PASSWORD="$1"
MYSQL_HOST="$2"
MYSQL_DB="$3"
AWS_BUCKET="$4"
NOW=$(date)

# create the backup
mysqldump -u root -p${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} ${MYSQL_DB} > "/tmp/db-$NOW.sql"

# uploads the backup to s3
aws s3 cp "/tmp/db-$NOW.sql" "s3://$AWS_BUCKET/db-$NOW.sql"

exit 0