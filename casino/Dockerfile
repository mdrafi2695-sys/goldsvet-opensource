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

WORKDIR /var/www/html

COPY . /var/www/html/

# public ఫోల్డర్ లేకపోతే క్రియేట్ చేసి, index.php ని సెట్ చేయడం
RUN mkdir -p public && \
    if [ ! -f public/index.php ]; then \
        echo "<?php \n\
        define('LARAVEL_START', microtime(true)); \n\
        require __DIR__.'/../vendor/autoload.php'; \n\
        \$app = require_once __DIR__.'/../bootstrap/app.php'; \n\
        \$kernel = \$app->make(Illuminate\Contracts\Http\Kernel::class); \n\
        \$response = \$kernel->handle( \n\
            \$request = Illuminate\Http\Request::capture() \n\
        );\n\
        \$response->send(); \n\
        \$kernel->terminate(\$request, \$response);" > public/index.php; \n\
    fi

# అపాచీ రూట్‌ను public కి మార్చడం
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

RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs --no-scripts --no-interaction

# పర్మిషన్స్ సెట్ చేయడం
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 777 storage \
    && chmod -R 777 bootstrap/cache

EXPOSE 80
