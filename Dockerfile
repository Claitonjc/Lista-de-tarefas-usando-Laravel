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

# Copia os arquivos do projeto
COPY . .

# Adiciona repositório como seguro (git)
RUN git config --global --add safe.directory /var/www/html

# Cria banco SQLite
RUN mkdir -p database && touch database/database.sqlite

# Permissões
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

# Corrige o DocumentRoot para a pasta public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Ativa o mod_rewrite do Apache
RUN a2enmod rewrite

# Instala dependências
RUN composer install --no-dev --optimize-autoloader

# Agora sim pode rodar comandos Artisan
RUN php artisan config:clear
RUN php artisan config:cache
RUN php artisan migrate --force || true

# Gera a chave da aplicação apenas se precisar (Render geralmente fornece via APP_KEY)
RUN php artisan key:generate || true

# Roda as migrations
RUN php artisan migrate --force || true

EXPOSE 80

