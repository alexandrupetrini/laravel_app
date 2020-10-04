FROM alexandrupetrini/php:7.4-fpm-alpine-production
COPY . /app
RUN cp .env.production .env
