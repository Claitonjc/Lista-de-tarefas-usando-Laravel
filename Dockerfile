# Usa a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instala dependências do sistema e extensões PHP necessárias para Laravel
RUN apt-get update && apt-get install -y \
    git unzip zip sqlite3 libsqlite3-dev libzip-dev libonig-dev \
    && docker-php-ext-install pdo pdo_sqlite mbstring zip

# Habilita mod_rewrite no Apache (necessário para Laravel)
RUN a2enmod rewrite

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia os arquivos do projeto para o container
COPY . .

# Instala o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Garante que o SQLite exista
RUN mkdir -p database && touch database/database.sqlite

# Permissões para o Laravel funcionar
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache

# Define a porta que o Apache irá escutar
EXPOSE 80
