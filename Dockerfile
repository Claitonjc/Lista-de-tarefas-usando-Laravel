FROM php:8.2-apache

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev libxml2-dev \
    libcurl4-openssl-dev pkg-config libssl-dev

# Instala extensões PHP necessárias
RUN docker-php-ext-install pdo pdo_sqlite bcmath mbstring zip xml curl

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Define diretório de trabalho
WORKDIR /var/www/html

# Copia projeto
COPY . .

# Adiciona o repositório como seguro (evita erro do Git no container)
RUN git config --global --add safe.directory /var/www/html

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Corrige o DocumentRoot para a pasta public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Ativa o mod_rewrite do Apache (necessário pro Laravel)
RUN a2enmod rewrite

# Cria banco SQLite e define permissões
RUN mkdir -p database && touch database/database.sqlite
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

EXPOSE 80

