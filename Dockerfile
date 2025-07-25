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

# Adiciona o repositório como seguro (evita erro do Git no container)
RUN git config --global --add safe.directory /var/www/html

# Cria banco SQLite
RUN mkdir -p database && touch database/database.sqlite

# Permissões para diretórios importantes
RUN chown -R www-data:www-data storage bootstrap/cache database
RUN chmod -R 775 storage bootstrap/cache database

# Corrige o DocumentRoot para a pasta public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Ativa o mod_rewrite do Apache (necessário pro Laravel)
RUN a2enmod rewrite

# Garante que o .env existe
RUN cp .env.example .env || true

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Gera chave da aplicação (caso não venha do Render)
RUN php artisan key:generate || true

# Roda as migrations (se o banco estiver preparado)
RUN php artisan migrate --force || true

EXPOSE 80

