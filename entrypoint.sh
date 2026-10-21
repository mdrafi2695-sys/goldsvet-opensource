#!/bin/bash
set -e

echo "Running migrations..."
cd /var/www/html/casino && php artisan migrate --force

echo "Running seeders..."
cd /var/www/html/casino && php artisan db:seed --force || true

echo "Starting Apache..."
exec apache2-foreground
