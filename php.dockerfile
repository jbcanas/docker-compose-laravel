FROM php:7.0-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk update \
  && apk add --no-cache \
    libmcrypt-dev zlib-dev libpng-dev libxml2-dev \
  && docker-php-ext-configure mcrypt --with-mcrypt \
  && docker-php-ext-configure bcmath --enable-bcmath \
  && docker-php-ext-configure zip \
  && docker-php-ext-install zip mysqli pdo pdo_mysql bcmath mcrypt gd mbstring

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www

RUN chown laravel:laravel /var/www

WORKDIR /var/www