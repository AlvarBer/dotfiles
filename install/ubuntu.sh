#!/bin/bash

# Add sublime text PPA and install it
add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer

# Installs htop
apt-get install htop

# Install byobu
apt-get install byobu

# Python Installation
apt-get install python3-pip
pip3 install virtualenv
git clone http://github.com/kennethreitz/autoenv.git ~/.autoenv

# After-Install GHCi fix
chmod g-w ~/.ghc
chmod g-w ~/.ghc/ghci.conf
