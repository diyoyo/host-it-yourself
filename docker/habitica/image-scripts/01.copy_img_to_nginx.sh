#!/usr/bin/env bash

git clone https://github.com/HabitRPG/habitica-images.git

cd habitica-images

png_list=$(find . -type f -name "*.png")
gif_list=$(find . -type f -name "*.gif")

source ../.env
echo ${NGINX_IMAGE_PATH}
mkdir -p ${NGINX_IMAGE_PATH}/images

for file in $png_list $gif_list;
  do
	base=$(basename $file)
	dir=$(dirname $file)

	cp $file ${NGINX_IMAGE_PATH}/images/$base
  done;

cd ..

rm -rf habitica-images
