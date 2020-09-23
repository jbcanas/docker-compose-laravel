FROM nginx:stable-alpine

ADD ./nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/container-dispatch.conf /etc/nginx/conf.d/container-dispatch.conf
ADD nginx/jplds.conf /etc/nginx/conf.d/jplds.conf
ADD nginx/payroll.conf /etc/nginx/conf.d/payroll.conf
ADD nginx/vlr.conf /etc/nginx/conf.d/vlr.conf

RUN mkdir -p /var/www/html

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN chown laravel:laravel /var/www/html