FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev

RUN docker-php-ext-install pdo pdo_sqlite mbstring zip xml curl tokenizer

RUN a2enmod rewrite

WORKDIR /var/www/html

COPY . .

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader

RUN mkdir -p database && touch database/database.sqlite

RUN chown -R www-data:www-data storage bootstrap/cache database

RUN chmod -R 775 storage bootstrap/cache database

EXPOSE 80
