#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install git npm tree

# the above will install nodejs too

# Install N (node version manager)
#https://github.com/visionmedia/n

sudo npm install -g n
# To install specific node version do the following
#sudo n 0.10.6
sudo n stable

# sudo npm install -g mocha
# sudo npm install -g coffee-script
# sudo npm install -g grunt-cli
# sudo npm install -g browserify