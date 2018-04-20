#!/bin/bash

clear

echo "Hi, $USER!"

#hash git &> /dev/null
#if [ $? -eq 1 ]; then
#  echo >&2 "Git not found."
#  echo "Installing Git in your machine..."
#  sudo apt install -y git-core
#fi

hash node &> /dev/null
if [ $? -eq 1 ]; then
  echo >&2 "NodeJS not found."
  echo "Installing NodeJS in your machine..."
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

cd api/

echo "Installing all the dependencies of your project..."
npm install

cd ..

echo "Enter a container name or leave it empty to install everything"
echo "> api"
echo "> nginx"
echo "> redis"
echo "> mongo"

read CONTAINERS

sudo docker-compose up -d $CONTAINERS
sudo docker ps -a
