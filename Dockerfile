# Utiliser une image PHP avec Apache
FROM php:8.2-apache

# Installer les extensions nécessaires pour Laravel et MySQL
RUN docker-php-ext-install pdo pdo_mysql

# Copier les fichiers du projet
COPY . /var/www/html/

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Aller dans le dossier et installer les dépendances
WORKDIR /var/www/html
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Donner les bons droits à Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 80 (Apache)
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
