FROM composer:2 as vendor


WORKDIR /tmp/

COPY blog/composer.json composer.json
COPY blog/composer.lock composer.lock
COPY blog/database ./database
COPY blog/tests ./tests

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist


FROM gsviec/nginx-php:7.4
USER root
RUN apk add gettext libintl && mv /usr/bin/envsubst /usr/local/sbin/envsubst 
COPY docker/nginx-heroku.conf /etc/nginx/nginx.conf
COPY ./blog /var/www/
COPY --from=vendor /tmp/vendor/ /var/www/vendor/
USER www-data
CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf" && supervisord -c '/etc/supervisor/conf.d/supervisord.conf'

