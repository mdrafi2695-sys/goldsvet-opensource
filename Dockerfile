FROM php:8.2-apache

# Install system dependencies & zip extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    curl \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache ModRewrite
RUN a2enmod rewrite headers

# Copy application files
COPY . /var/www/html/

# Run Composer Install if casino folder exists
WORKDIR /var/www/html/casino
RUN if [ -f "composer.json" ]; then composer install --no-dev --optimize-autoloader; fi

WORKDIR /var/www/html
RUN if [ -f "composer.json" ]; then composer install --no-dev --optimize-autoloader; fi

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Apache VirtualHost Configuration
RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/custom.conf \
    && a2enconf custom

EXPOSE 80
