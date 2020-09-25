FROM php:5.6-fpm-alpine

RUN apk update \
  && apk add --no-cache \
    coreutils \
    freetype-dev \
    libjpeg-turbo-dev \
    libltdl \
    libmcrypt-dev \
    libpng-dev \
    zlib-dev \
  && docker-php-ext-configure mcrypt --with-mcrypt \
  && docker-php-ext-configure opcache \
  && docker-php-ext-install mysqli pdo pdo_mysql mcrypt zip gd opcache

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