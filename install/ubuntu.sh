#!/bin/sh

# Add sublime text PPA and install it
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer -y

# Installs htop
sudo apt-get install htop -y

# Install byobu
sudo apt-get install byobu -y

# Python Installation
git clone http://github.com/kennethreitz/autoenv.git ~/.autoenv

# After-Install GHCi fix
chmod g-w ~/.ghc
chmod g-w ~/.ghc/ghci.conf

