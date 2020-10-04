#!/bin/bash
app_name="app"
nginx_name="nginx"
networkName="app-network"
app_prod='alexandrupetrini/php:7.4-fpm-alpine-production'
nginx_prod='alexandrupetrini/nginx:1.18.0-alpine-production'

if [ -z "$(docker network ls -f name=$networkName -q)" ]; then docker network create --driver bridge $networkName; fi

if [ -n "$(docker container ls -f name=$nginx_name -q)" ]; then docker rm -f $nginx_name; fi
sleep 1
if [ -n "$(docker container ls -f name=$app_name -q)" ]; then docker rm -f $app_name; fi

docker container run -d --name=$app_name --network $networkName --restart always $app_prod
docker container run -d --name=$nginx_name --network $networkName -p 80:8181 -p 443:8143 --restart always $nginx_prod
