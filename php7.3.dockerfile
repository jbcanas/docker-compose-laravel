FROM php:7.3.6-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk update \
  && apk add --no-cache \
    libmcrypt-dev \
    zlib-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
  && pecl install mcrypt-1.0.3 \
  && docker-php-ext-configure bcmath --enable-bcmath \
  && docker-php-ext-configure zip \
  && docker-php-ext-enable mcrypt \
  && docker-php-ext-install zip mysqli pdo pdo_mysql bcmath opcache

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www

RUN chown laravel:laravel /var/www

WORKDIR /var/www