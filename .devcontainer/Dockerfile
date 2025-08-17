FROM php:8.4-apache-bookworm

# Install system dependencies for PHP extensions
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libzip-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 vscode
RUN groupadd -g 999 docker || true
RUN usermod -aG docker vscode
RUN apt-get update && apt-get install -y docker.io

# Install PHP extensions (if needed). Official PHP images do not use apt-get for PHP extensions
# so we use docker-php-ext-install to compile and enable them.
RUN docker-php-ext-install mbstring xml curl zip

# Install Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Xdebug config
COPY resources/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
RUN mkdir -p /var/log/xdebug && chmod 777 /var/log/xdebug

# Configure Apache
RUN echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite

COPY resources/setup.sh /usr/local/bin/phpbb-setup.sh
RUN chmod +x /usr/local/bin/phpbb-setup.sh
CMD ["/usr/local/bin/phpbb-setup.sh"]