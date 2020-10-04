FROM alexandrupetrini/php:7.4-fpm-alpine-production
# COPY ./ /app
# COPY ./.* /app
RUN git clone https://github.com/alexandrupetrini/laravel_app.git /app
WORKDIR /app
# RUN cp .env.production .env
