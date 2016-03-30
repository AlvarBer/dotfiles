# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

###############################################################################
# Prompt & Colors

# set a fancy prompt (non-color, unless we know we "want" color)
if [ $(tput colors) -gt 1 ]; then
	export COLOUR=yes # This doesn't cover all cases, but what does?
else
	export COLOUR=no
fi

if [ "$COLOUR" = "yes" ]; then
	. ~/.bash_colours # Source Bash Colours
	
	# colored GCC warnings and errors
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

. ~/.bash_prompt

# Byobu Prompt in case we are in byobu
if [ -r /home/mortadelegle/.byobu/prompt ]; then
	. /home/mortadelegle/.byobu/prompt
fi

###############################################################################

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f ~/.bash_aliases ]]; then
	. ~/.bash_aliases
fi

###############################################################################
# Auto Completion

# Enable programmable completion features (you don't need to enable this, if it
# is already enabled in /etc/bash.bashrc and /etc/profile sources that file).
if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		. /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		. /etc/bash_completion
	fi
fi

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
	complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

###############################################################################
# Dotfiles synchronization

# Adds an entry to the PATH after trying to remove it, 
# as seen on http://stackoverflow.com/a/2108540/142339
TMP=:$PATH:
TMP=${TMP/:~/dotfiles/bin:/:}
TMP=${TMP%:}
TMP=${TMP#:}
PATH=$TMP
PATH=~/dotfiles/bin:$PATH
