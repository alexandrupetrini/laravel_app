FROM alexandrupetrini/php:7.4-fpm-alpine-production
RUN git clone https://github.com/alexandrupetrini/laravel_app.git /app

WORKDIR /app

RUN cp .env.production .env \
    && composer install \
    && npm install && npm run prod \
    && php artisan optimize

RUN chown -R 1000:1000 /app \
    && chmod -R 777 /app/storage
