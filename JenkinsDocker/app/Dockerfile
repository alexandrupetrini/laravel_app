FROM php:7.4-fpm-alpine

ARG PHP_ENV

# install bash and bin folder
RUN apk add --update --no-cache git bash \
    && bash \
    && mkdir -p ~/.bin \
    && echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\w\e\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" > ~/.bashrc \
    && echo "export PATH=~/.bin:$PATH" >> ~/.bashrc

RUN cp -fv "${PHP_INI_DIR}/php.ini-${PHP_ENV}" "${PHP_INI_DIR}/php.ini"

# Additional extensions
RUN apk add --update --no-cache $PHPIZE_DEPS icu-libs icu-dev oniguruma-dev \
    && docker-php-ext-install intl || true \
    && docker-php-ext-install bcmath || true \
    && docker-php-ext-install ctype || true \
    && docker-php-ext-install fileinfo || true \
    && docker-php-ext-install json || true \
    && docker-php-ext-install mbstring || true \
    && docker-php-ext-install pdo || true \
    && docker-php-ext-install pdo_mysql || true \
    && docker-php-ext-install mysqli || true \
    && docker-php-ext-install tokenizer || true \
    && docker-php-ext-install xml || true \
    && docker-php-ext-install opcache || true

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install NodeJs
RUN apk add --update --no-cache nodejs nodejs-npm && \
    npm install -g npm@latest

## Install Laravel client
RUN apk add --update --no-cache git \
    && composer global require "laravel/installer" \
    && ln -sf /root/.composer/vendor/bin/laravel ~/.bin
COPY . /app

WORKDIR /app
