#!/bin/bash

# Here we syncronize/pull all files and link them
synchronize() {
	NAME=AlvarBer
	WEBSITE=github.com
	remoteurl=https://${NAME}@${WEBSITE}/${NAME}/dotfiles.git
	sshurl=git@${WEBSITE}:${NAME}/dotfiles.git
	
	get_distro
	get_install

	if [[ ! $(type -P git) ]]; then
		if [[ $1 == "-v"  ]]; then
			printf "Installing git\n"
		fi
		sudo ${install} git
		if [[ $? -eq 1 ]]; then
			printf "git couldn't be installed, install it and try again\n"
			exit 1
		fi
	fi
	if [[ ! -d dotfiles ]]; then
		git clone $remoteurl ~/dotfiles
		#git remote set-url origin sshurl
		
		cd ~/dotfiles
		mkdir backup
		if [[ $(whoami) == "root" ]]; then 
			install/${DISTRIB_ID}.sh 2> /dev/null
		else
			printf "You need sudo to install the programs\n" 
		fi
		delete_self=true
		rm -- "$0"
	else
		cd dotfiles
		git fetch origin master
		if [[ $(git rev-parse @) == $(git rev-parse @{u}) ]]; then
			printf "No new changes in dotfiles upstream\n"
			exit 0 # This conditionals checks for updates in the remote
		fi
		git merge origin/master
	fi
	cd linked
	for file in $(find . -maxdepth 1 -mindepth 1 -name * -type f); do
		if [[ -f ~/$file ]]; then
			if [[ $1 == "-v" ]]; then
				printf "File %s already exists in ~, backing up\n" " $file"
			fi
			mv -f ~/$file ~/dotfiles/backup
			ln -s $(pwd)/$file ~
		else
			ln -s $(pwd)/$file ~
		fi
	done
	for dir in $(find . -maxdepth 1 -mindepth 1 -name * -type d); do
		if [[ -d ~/$dir ]]; then
			if [[ $1 == "-v" ]]; then
				printf "Dir %s already in ~, preserving content\n" "$dir"
			fi
			mkdir ~/tmp
			mv ~/$dir/* ~/tmp
			rm -d ~/$dir
			ln -s $(pwd)/$dir ~
			mv -n ~/tmp/* ~/$dir
			rm -rf ~/tmp
		else
			ln -s $(pwd)/$dir ~
		fi
	done
	if [[ $delete_self == "true" ]]; then
		rm -- $0
	fi
}

# This gets the distro name (If possible)
get_distro() {
	if [[ -z DISTRIB_ID ]]; then
		if [[ -f /etc/lsb-release ]]; then
			source /etc/lsb-release
		else
			printf "Couldn't determine distro\n"
			exit 1
		fi
	fi
}

get_install() {
	case $DISTRIB_ID in
		"elementary OS" | "ubuntu" | "debian") install="apt-get install";;
		"apricity" | "arch linux") install="pacman -S";;
		*) install="apt-get install";;
	esac
}

synchronize $@
