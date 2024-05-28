#!/usr/bin/env bash

source .env

cp docker-compose.yml.example ${NGINX_IMAGE_PATH}/docker-compose.yml

cp .env ${NGINX_IMAGE_PATH}/

cd ${NGINX_IMAGE_PATH}

docker compose up -d
