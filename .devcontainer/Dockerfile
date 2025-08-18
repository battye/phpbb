# Image version
ARG VARIANT="bookworm"
FROM mcr.microsoft.com/vscode/devcontainers/php:8.4-apache-${VARIANT}

# Install PHP
RUN apt-get -y update && apt-get -y install \
    php8.4 \
    php8.4-xml \
    php8.4-mbstring \
    php8.4-curl \
    php8.4-zip \
    php8.4-xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install MySQL
RUN apt-get -y install mysql-server php-mysql

# Xdebug
ADD resources/xdebug.ini /etc/php/8.4/apache2/conf.d/xdebug.ini

# Configure Apache
RUN echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite
