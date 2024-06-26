#!/usr/bin/env bash

source .env

date=$(echo `date +"%y%m%d_%H%M"`)
echo $date

CSS_BASE_DIR="website/client/src/assets/css"
css_dir="${HABITICA_PARENT_DIR}/habitica/${CSS_BASE_DIR}"

files="sprites.css sprites/spritesmith-main.css"

AWS_IMG_BASE_URL="https://habitica-assets.s3.amazonaws.com/mobileApp/images"
AIBU=${AWS_IMG_BASE_URL//'/'/'\/'}
echo $AIBU

#SELFHOSTED_IMG_BASE_URL is defined in .env
SHIBU=${SELFHOSTED_IMG_BASE_URL//'/'/'\/'}
echo $SHIBU

for file in $files;
  do
	echo "Editing $file"

	sed -i.bak$date s/${AIBU}/${SHIBU}/ $css_dir/$file
	echo ${CSS_BASE_DIR}/$file >> ${HABITICA_PARENT_DIR}/habitica/.gitignore

  done;

echo "*.bak*" >> ${HABITICA_PARENT_DIR}/habitica/.gitignore


