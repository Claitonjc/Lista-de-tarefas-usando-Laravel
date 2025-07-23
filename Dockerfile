FROM php:8.2-apache

# Instala dependências do sistema (essenciais para compilar extensões PHP)
RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev libxml2-dev \
    libcurl4-openssl-dev pkg-config libssl-dev

# Instala extensões PHP necessárias para Laravel e SQLite
RUN docker-php-ext-install pdo pdo_sqlite mbstring zip xml curl

# Habilita mod_rewrite do Apache (necessário para Laravel)
RUN a2enmod rewrite

# Define diretório de trabalho
WORKDIR /var/www/html

# Copia código do projeto
COPY . .

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Cria banco SQLite e dá permissões corretas
RUN mkdir -p database && touch database/database.sqlite
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

EXPOSE 80
