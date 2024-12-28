FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    zip unzip curl libpng-dev libonig-dev libxml2-dev libzip-dev git \
    libicu-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip intl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy Laravel project files
COPY ./app /var/www/html

# Install dependencies
RUN composer install

# Set permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Configure Git to allow using the directory even with dubious ownership
RUN git config --global --add safe.directory /var/www/html

# Expose port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
