#!/bin/bash

httpd & mysqld_safe --skip-grant-tables --skip-networking &
sleep 2

if [ -n "$RESTORE_SQL_DUMP" ]; then
    echo "create database drupal" | mysql -u root
    mysql -u root drupal < /var/www/dump.sql
fi

/bin/bash
cd /var/www