FROM php:7.3.6-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk update \
  && apk add --no-cache \
    libmcrypt-dev zlib-dev libzip-dev \
  && docker-php-ext-configure bcmath --enable-bcmath \
  && docker-php-ext-configure zip \
  && docker-php-ext-install zip mysqli pdo pdo_mysql bcmath opcache

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www

RUN chown laravel:laravel /var/www

WORKDIR /var/www