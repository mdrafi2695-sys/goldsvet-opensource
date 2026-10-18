FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql mbstring exif pcntl bcmath gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite headers

# అపాచీ సర్వర్ రూట్‌ను ఆటోమేటిక్‌గా public ఫోల్డర్‌కి సెట్ చేయడం
RUN echo '<VirtualHost *:80>\n\
    ServerAdmin webmaster@localhost\n\
    DocumentRoot /var/www/html/public\n\
    <Directory /var/www/html/public>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
    ErrorLog ${APACHE_LOG_DIR}/error.log\n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

COPY . /var/www/html/

# కంపోజర్ డిపెండెన్సీలను ఆటోమేటిక్‌గా ఇన్‌స్టాల్ చేయడం
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs --no-scripts --no-interaction

# స్టోరేజ్ మరియు క్యాష్ పర్మిషన్స్ ఆటోమేటిక్‌గా ఫుల్ యాక్సెస్ ఇవ్వడం
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 storage \
    && chmod -R 777 bootstrap/cache

EXPOSE 80
