# Etapa para baixar o Composer
FROM composer:2 as composer

# Etapa principal com PHP + Apache
FROM php:8.2-apache

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev libxml2-dev \
    libcurl4-openssl-dev pkg-config libssl-dev

# Instala extensões PHP necessárias
RUN docker-php-ext-install pdo pdo_sqlite bcmath mbstring zip xml curl

# Instala Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Define diretório de trabalho
WORKDIR /var/www/html

# Copia arquivos do projeto
COPY . .

# Marca o repositório Git como seguro
RUN git config --global --add safe.directory /var/www/html

# Corrige DocumentRoot para /public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Ativa mod_rewrite do Apache
RUN a2enmod rewrite

# Instala dependências Laravel
RUN composer install --no-dev --optimize-autoloader

# Cria banco e permissões
RUN mkdir -p database && touch database/database.sqlite
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

EXPOSE 80

