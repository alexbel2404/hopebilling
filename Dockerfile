FROM php:7.3-apache

RUN apt-get update && \
    apt-get install -y apt-utils zlib1g-dev libzip-dev libpng-dev libxml2-dev && \
    a2enmod rewrite && \
    docker-php-ext-install -j$(nproc) pdo_mysql zip gd soap && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

COPY src/ /var/www/html/

RUN chmod 777 /var/www/html/app/config && \
    chmod 777 /var/www/html/app/config/global.config && \
    chmod 777 /var/www/html/app/config/payments.config && \
    chmod 777 /var/www/html/app/config/sms-gateway.config && \
    chmod -R 777 /var/www/html/storage