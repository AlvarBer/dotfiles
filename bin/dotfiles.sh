#!/usr/bin/env sh

# synch pull lastest changes and merges them
synch() {
	cd ~/dotfiles
	git fetch origin master
	if [ "$(git rev-parse master)" = "$(git rev-parse origin/master)" ]; then
		echo No new changes in dotfiles upstream
		exit 0
	else
		git merge origin/master  # Simple update
		if git diff --name-status master origin/master | grep -E "^A|^C|^R|^T"; then
			if [ "$verbose" ]; then  # Not so simple update
				echo Relinking
			fi
			cd linked/
			link_linked "$(find . -type f -or -type l -printf '%P\n')"  # Relinking
		fi
	fi
}

# clone is for the first tim we run dotfiles
clone() {
	cd ~
	if ! git --version >/dev/null 2>&1; then
		echo git is not installed, install it and try again 2>&1
		exit 1
	fi
	if [ ! -d dotfiles ]; then
		echo Cloning dotfiles repo
		git clone "$remoteurl" dotfiles
		#git remote set-url origin sshurl
		
		installs
		cd ~/dotfiles/linked
		link_linked "$(find . -type f -or -type l -printf '%P\n')"
	else
		echo Already cloned!
		exit 1
	fi
}

# installs installs the specific script
installs() {
	cd ~/dotfiles
	if [ "$(id -u)" = 0 ]; then  # Checking for sudo
		${DISTRIB_ID:-$(. /etc/lsb-release)}
		if [ ! -z "$DISTRIB_ID" ]; then  # Checking distro
			install/"${DISTRIB_ID}".sh
		else
			echo Your distro has not install script 2>&1
		fi
	else
		echo You need sudo to run install script 2>&1
	fi
}

# link_linked is the main linking process, it is used both for clone and synch
link_linked() {
	cd ~/dotfiles/linked
	rm -rf ../backup && mkdir ../backup
	for element in $(find -H . -type f -or -type l | sed 's|./||'); do
		if [ -f ~/"$element" ] || [ -d ~/"$element" ] || [ -h ~/"$element" ]; then  # If the linked file already at ~
			mv ~/"$element" ../backup/  # We move it to backup
			if [ "$verbose" ]; then
				echo "$element" moved to backup
			fi
		elif [ ! -d ~/"$(dirname "$element")" ]; then  # If some of the dirs don't exist
			mkdir --parents ~/"$(dirname "$element")"  # We create them
			if [ "$verbose" ]; then
				echo Dirs ~/"$(dirname "$element")" created
			fi
		fi
		#ln -nsr "$file" ~/$(dirname "$file") dereferences links :(
		ln --symbolic --no-dereference --target-directory="$HOME/$(dirname "$element")" "$(pwd)"/"$element"
		if [ "$verbose" ]; then
			echo $element is now linked on ~
		fi
	done
}

add() {
	echo Pending functionality
}


# Script itself
set -e
NAME=AlvarBer
WEBSITE=github.com
remoteurl=https://${NAME}@${WEBSITE}/${NAME}/dotfiles.git
#sshurl=git@${WEBSITE}:${NAME}/dotfiles.git

while [ $# -gt 0 ]; do
	case $1 in
		-v | --verbose)
			verbose=True
			shift;;
		add)
			action="add '$@'"
			shift;;
		unlink)
			echo Pending functionality
			shift;;
		clone)
			action=clone
			shift;;
		install)
			action=installs
			shift;;
		sync)
			action=synch
			shift;;
		test)
			shift;;
		link)
			action="cd ~/dotfiles/linked && link_linked" 
			shift;;
		*)
			if [ ! -d ~/dotfiles ]; then
				action=clone
			else
				action=synch
			fi
			shift;;
	esac
done
eval $action
