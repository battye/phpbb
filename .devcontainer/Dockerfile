# Image version
ARG VARIANT="bookworm"
FROM mcr.microsoft.com/vscode/devcontainers/php:8.4-apache-${VARIANT}

# Install PHP
RUN sudo apt-get update && \
    sudo apt-get -y install lsb-release ca-certificates curl apt-transport-https && \
    sudo curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb && \
    sudo dpkg -i /tmp/debsuryorg-archive-keyring.deb && \
    sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
    sudo apt-get update

RUN apt-get -y update && apt-get -y install \
    php-xml \
    php-mbstring \
    php-curl \
    php-zip \
    php-xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install MySQL
RUN apt-get -y install mysql-server php-mysql

# Xdebug
ADD resources/xdebug.ini /etc/php/8.4/apache2/conf.d/xdebug.ini

# Configure Apache
RUN echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite
