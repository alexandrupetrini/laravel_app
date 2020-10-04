FROM nginx:1.18.0-alpine
COPY certs /nginx-certs
COPY ./Docker/nginx/vhosts/my_server_block_http_https.conf /etc/nginx/conf.d/my_server_block_http_https.conf
