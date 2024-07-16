export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mh"

plugins=(git sudo)

source $ZSH/oh-my-zsh.sh

alias i="sudo pacman -S"
alias m="make"
alias n="nvim"