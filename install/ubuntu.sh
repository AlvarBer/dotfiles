#!/bin/bash

# Add sublime text PPA and install it
add-apt-repository ppa:webupd8team/sublime-text-3
apt-get update
apt-get install sublime-text-installer

# Installs htop
apt-get install htop

# After-Install GHCi fix
chmod g-w ~/.ghc
chmod g-w ~/.ghc/ghci.conf
