FROM  gsviec/nginx-php:7.4

USER root
COPY docker/nginx-heroku.conf /etc/nginx/nginx.conf

RUN apk add gettext libintl && mv /usr/bin/envsubst /usr/local/sbin/envsubst 
RUN chown www-data:www-data /var/www
WORKDIR /var/www
COPY ./blog ./
RUN composer install  --no-interaction --no-dev  -vvv
RUN ls -la
CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf" && supervisord -c '/etc/supervisor/conf.d/supervisord.conf'
