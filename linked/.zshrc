source /usr/share/zsh/site-contrib/powerline.zsh

source ~/.aliases.sh

# Exporting variables
export TERM=screen-256color
export JAVA_HOME=/usr/bin/java
export EDITOR=nvim

# Autocompletion
zstyle ':completion:*' menu select
autoload compinit
autoload bashcompinit
compinit
bashcompinit
eval "$(pandoc --bash-completion)"


