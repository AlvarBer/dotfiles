#!/bin/sh


# System upgrade
sudo apt-get update && sudo apt-get upgrade

# Add sublime text PPA
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update

# Programs installation
sudo apt-get install sublime-text-installer -y
sudo apt-get install htop -y
sudo apt-get install byobu -y

# Extras installation
git clone http://github.com/kennethreitz/autoenv.git ~/.autoenv
# Vim plug installation

# After-Install GHCi fix
chmod g-w ~/.ghc
chmod g-w ~/.ghc/ghci.conf

