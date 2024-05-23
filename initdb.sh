#!/bin/bash

set -e

# Wait for MySQL to be ready
until mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
  echo 'Waiting for MySQL to be ready...'
  sleep 1
done

# Execute the init script
mysql -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/init.sql

exec "$@"
