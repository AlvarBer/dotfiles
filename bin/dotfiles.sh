#!/bin/bash

NAME=AlvarBer
WEBSITE=github.com

# Here we syncronize/pull all files and link them
dotfiles() {
	remoteurl=https://${NAME}@${WEBSITE}/${NAME}/dotfiles.git
	sshurl=git@${WEBSITE}:${NAME}/dotfiles.git
	get_distro

	install=get_install
	cd ~
	if [[ ! $(type -P git) ]]; then
		printf "Installing git"
		sudo ${install} git
		if [[ $? -eq 1 ]]; then
			printf "git couldn't be installed, install it and try again"
			exit 1
		fi
	fi
	if [[ ! -d dotfiles ]]; then
		git clone $remoteurl dotfiles
		#git remote set-url origin sshurl
		cd dotfiles
		mkdir backup
		get_distro
		if [[ $(whoami) == "root" ]]; then 
			install/${DISTRIB_ID}.sh 2> /dev/null
		else
			printf "You need sudo to install the programs" 
		fi	
	else
		cd dotfiles
		git fetch origin master
		if [[ $(git rev-parse @) == $(git rev-parse @{u}) ]]; then
			printf "No new changes in dotfiles upstream"
			exit 0 # This conditionals checks for updates in the remote
		fi
		git merge origin/master
	fi
	cd linked
	for file in $(find . -maxdepth 1 -mindepth 1 -name * -type f); do
		ln -s $(pwd)/$file ~/$file # File Soft Linking
		if [[ $? -eq 1 ]] ; then
			echo 'File already exists in ~, moving it to backup'
			mv ~/$file ~/dotfiles/backup
			ln -s $(pwd)/$file ~/$file
		fi
	done
	for dir in $(find . -maxdepth 1 -mindepth 1 -name * -type d); do
		ln -s $(pwd)/$dir ~ # Directories Soft Linking
		if [[ $? -eq 1 ]] ; then
			echo 'Dir already exists in ~, preserving previous contents'
			mv ~/$dir ~/tmp
			ln -s $(pwd)/$dir ~/$dir
			mv -n ~/tmp/* ~/$dir
			rm -rf ~/tmp
		fi
	done
}

# This gets the distro name (If possible)
get_distro() {
	if [[ -z DISTRIB_ID ]]; then
		if [[ -f /etc/lsb-release ]]; then
			source /etc/lsb-release
		else
			printf "Couldn't determine distro"
			exit 1
		fi
	fi
}

get_install() {
	case $DISTRIB_ID in
		"elementary OS" "ubuntu" "debian") install="apt-get install";;
		"apricity" "arch linux") install="pacman -S";;
		*) install="apt-get install";;
	esac
}

dotfiles "$@"
