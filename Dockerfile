FROM alpine:latest

WORKDIR /var/www/html

RUN apk add --no-cache \
  curl \
  nginx \
  php81 \
  php81-ctype \
  php81-curl \
  php81-dom \
  php81-fpm \
  php81-gd \
  php81-intl \
  php81-mbstring \
  php81-mysqli \
  php81-opcache \
  php81-openssl \
  php81-phar \
  php81-session \
  php81-xml \
  php81-xmlreader \
  php81-zlib \
  supervisor

RUN ln -s /usr/bin/php81 /usr/bin/php

COPY default.conf /etc/nginx/conf.d/deafault.conf
COPY index.html /var/www/html

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY php.ini /etc/php81/conf.d/custom.ini

RUN chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

USER nobody

EXPOSE 8081

COPY --chown=nobody src/ /var/www/html/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

