
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' format 'Completando %d'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=* r:|=*'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/ldlpiao/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

eval "$(starship init zsh)"
source <(fzf --zsh)
