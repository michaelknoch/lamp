#!/bin/bash

httpd
/etc/init.d/mysql start

if [ -n "$RESTORE_SQL_DUMP" ]; then
    echo "create database drupal" | mysql -u root
    mysql -u root drupal < /var/www/dump.sql
fi

/bin/bash