#!/bin/sh


# Install Firefox
sudo apt-get install firefox

# Unistall midori piece of crap
sudo apt-get purge midori

# Make computer not suspend when closing the lid
sudo apt-get install dconf-editor

# Run same config as in Ubuntu 
source ./ubuntu.sh
