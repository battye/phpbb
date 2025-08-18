# Image version
FROM mcr.microsoft.com/vscode/devcontainers/php:8.4-apache-${VARIANT}

# Install PHP
RUN apt-get -y update
RUN apt-get -y install php php-xml php-mbstring php-curl php-zip php-xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install MySQL
RUN apt-get -y install mysql-server php-mysql

# Xdebug
ADD resources/xdebug.ini /etc/php/8.1/apache2/conf.d/xdebug.ini

# Configure Apache
RUN echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite
