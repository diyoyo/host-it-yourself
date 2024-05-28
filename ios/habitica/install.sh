#!/usr/bin/env bash

#####
echo "Cloning..."
#####

git clone https://github.com/HabitRPG/habitica-ios

cd habitica-ios

#####
echo "Normal operations..."
#####


bundle install

bundle exec pod install


#####
echo "Main replacements..."
#####

../xc-host-config.sh

#####
echo "Copying sample secrets file and adding it to conf ..."
#####

cp secrets.yml.example secrets.yml

if which swiftgen >/dev/null; then
  echo "INFO: SwiftGen detected at $(which swiftgen)"
else
  echo "****"
  echo "**WARNING** No 'SwiftGen' detected in your environment"
  echo "Consider installing it using:"
  echo "          brew install swiftgen"
  echo "****"
fi;

python ../xc-rm-entitlements.py


#####
echo "Cleaning up..."
#####

find . -name "*.bak*" -delete

#####
echo "Launching XCode..."
#####

read -p "Ready to start XCode?"
read -p "Important info: First build may still fail because of Generated secrets. Just clean and try again!"

open ./Habitica.xcworkspace
