dotfiles <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/master/dotfiles-logo-icon.png" alt="dotfiles logo icon" width="30">
========
A minimal dotfiles system inspired by [cowboy dotfiles].

Mainly done for learning purposes, backup everything you hold dear.

Only works in some select Linux distros (Mainly those with apt-get Arch and Apricity).

One liner
---------
```wget https://raw.githubusercontent.com/AlvarBer/dotfiles/master/bin/dotfiles.sh -O - | sudo bash```

backup folder
-------------
Folder which fills up when a synchronization happens and there is a clash.

bin folder
----------
All files here are considered executables.

`dotfiles.sh` is where the main synchronization happens.

This whole folder should be sourced in your *bashrc*, *zshrc*, etc...

install folder
--------------
This folder is only executed the first time, it performs the installation of 
the programs you want if the distro you are on is named as one of the scripts.

linked folder
-------------
Everything here (files & folders) is (hard)linked into ~

Careful with putting information here, it can end up in your repo (By default git will ignore it)


[cowboy dotfiles]: https://github.com/cowboy/dotfiles
