FROM mariadb:10.5
ENV MYSQL_ROOT_PASSWORD=lararoot
ENV MYSQL_DATABASE=laravel
ENV MYSQL_USER=laraveluser
ENV MYSQL_PASSWORD=wJk7h^*&HDU2Kf

COPY dump/laravel_db_dump.sql /

RUN mysql -uroot -plararoot laravel < /laravel_db_dump.sql \
    && rm /laravel_db_dump.sql

