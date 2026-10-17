FROM php:8.2-apache

# Install system dependencies & PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache ModRewrite
RUN a2enmod rewrite headers

# Copy application files
COPY . /var/www/html/

# Set DocumentRoot to point directly to /var/www/html (since index/server files are in root)
RUN sed -i 's!/var/www/html!/var/www/html!g' /etc/apache2/sites-available/000-default.conf

# Run composer install
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs --no-scripts --no-interaction

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Apache VirtualHost Configuration to use server.php as fallback if index.php is missing
RUN echo '<Directory /var/www/html/>\n\
    DirectoryIndex index.php server.php\n\
    Options FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/custom.conf \
    && a2enconf custom

EXPOSE 80
