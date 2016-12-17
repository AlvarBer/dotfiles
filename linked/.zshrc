source /usr/share/zsh/site-contrib/powerline.zsh

source ~/.aliases

export TERM=screen-256color

# Autocompletion
zstyle ':completion:*' menu select
autoload compinit
autoload bashcompinit
compinit
bashcompinit
eval "$(pandoc --bash-completion)"

