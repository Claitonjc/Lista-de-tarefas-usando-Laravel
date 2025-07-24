FROM php:8.2-apache

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev libxml2-dev \
    libcurl4-openssl-dev pkg-config libssl-dev

# Instala extensões PHP necessárias
RUN docker-php-ext-install pdo pdo_sqlite bcmath mbstring zip xml curl

# Habilita mod_rewrite do Apache (Laravel precisa)
RUN a2enmod rewrite

# Adiciona o diretório como "safe" para o Git
RUN git config --global --add safe.directory /var/www/html

# Define diretório de trabalho
WORKDIR /var/www/html

# Copia projeto
COPY . .

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala dependências
RUN composer install --no-dev --optimize-autoloader

# Cria banco SQLite e garante permissões
RUN mkdir -p database && touch database/database.sqlite
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

EXPOSE 80

