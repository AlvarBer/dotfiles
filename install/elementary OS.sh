#!/bin/sh


# Install Firefox
sudo apt-get install firefox -y

# Unistall Midori
sudo apt-get purge midori -y

# Make computer not suspend when closing the lid
sudo apt-get install dconf-editor

# Run same config as in Ubuntu 
. ./ubuntu.sh

