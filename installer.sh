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
  sudo apt update && sudo apt install -y nodejs
fi

hash yarn &> /dev/null
if [ $? -eq 1 ]; then
  echo >&2 "Yarn not found."
  echo "Installing Yarn in your machine..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install -y yarn
fi

cd api/

echo "Installing all the dependencies of your project..."
yarn install

cd ..

echo "Enter the names of the containers separated by space"
echo "or leave them empty to install everything"
echo "> api"
echo "> nginx"
echo "> redis"
echo "> mongosetup"

read CONTAINERS

sudo docker-compose up -d $CONTAINERS
sudo docker ps -a

echo "Completed process!"
