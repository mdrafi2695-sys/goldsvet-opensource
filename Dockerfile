RUN printf '<VirtualHost *:10000>\n\
  ServerAdmin webmaster@localhost\n\
  DocumentRoot /var/www/html\n\
  <Directory /var/www/html>\n\
      Options Indexes FollowSymLinks\n\
      AllowOverride All\n\
      Require all granted\n\
  </Directory>\n\
  DirectoryIndex index.php index.html\n\
  ErrorLog ${APACHE_LOG_DIR}/error.log\n\
  CustomLog ${APACHE_LOG_DIR}/access.log combined\n\
</VirtualHost>\n' > /etc/apache2/sites-available/001-default.conf
