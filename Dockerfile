FROM centos:7

COPY etc/yum.repos.d/MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum  -y update && \
    yum makecache fast && \
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install yum-utils && \
    yum-config-manager --enable remi-php73

RUN yum -y install netstat vim which wget && \
    yum -y install httpd php mariadb-server phpmyadmin && \
    yum clean all

RUN mkdir -p /var/www/html && \
    echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

RUN wget https://github.com/drush-ops/drush/releases/download/8.3.1/drush.phar && \
    chmod +x drush.phar && mv drush.phar /usr/local/bin/drush

RUN echo "error_log = /var/log/php-scripts.log" >> /etc/php.ini
RUN echo "cd /var/www" >> /root/.bashrc

COPY etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf
COPY etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf
COPY etc/my.cnf /etc/my.cnf

COPY docker_start.sh /
ENTRYPOINT ["/docker_start.sh"]
