FROM alexandrupetrini/php:7.4-fpm-alpine-production
COPY ./ /app
COPY ./.* /app
RUN cp /app/.env.production /app/.env
