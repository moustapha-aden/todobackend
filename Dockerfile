# On part d'une image PHP avec Apache
FROM php:8.2-apache

# Installer les extensions PHP nécessaires pour Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copier le code dans le conteneur
COPY . /var/www/html/

# Aller dans le dossier du projet
WORKDIR /var/www/html

# Installer les dépendances Laravel
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Donner les permissions correctes à Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exposer le port 80 (Apache)
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
