# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/USER/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

unsetopt share_history

# Environment variables
export MAKEFLAGS="-j$(nproc)"
export PROMPT="%F{green}%n@%m %d $%f"
export WLR_NO_HARDWARE_CURSORS=1
export PATH="$HOME/.local/bin/statusbar/:$PATH"

# Aliases
alias ls="ls -la --color=auto"
