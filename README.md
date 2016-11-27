dotfiles <img src="https://raw.githubusercontent.com/jglovier/dotfiles-logo/master/dotfiles-logo-icon.png" alt="dotfiles logo icon" width="30">
========
A minimal dotfiles system inspired by [cowboy dotfiles].

Dotfiles should accommodate to your needs, these dotfiles are simple, yet handle relative complex config such as symlink directories.

Written on POSIX shell, should work on almost anything unix-y.

One liner
---------
```wget https://raw.githubusercontent.com/AlvarBer/dotfiles/master/bin/dotfiles.sh && sudo ./dotfiles.sh```

Quick guide
-----------
Every folder does something different, following are the functions of each one, if you are installing for the first time
you run the one liner and it should be done.
After that you hav different options, but with a `dotfiles.sh` your dotfiles should synchronize with your remote repo.

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
Everything here (files & empty folder that are soft links) are symlinked into ~

Careful with putting information here like ssh, it can end up in your repo.


[cowboy dotfiles]: https://github.com/cowboy/dotfiles
