# Source the aliases
source $HOME/.aliases

# Created by newuser for 5.4.2
# Configure prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Keybinding for connecting to UPC via VPN
bindkey -s '^v' 'f5fpc -s -x -t https://upclink.upc.edu\n'
bindkey -s '^s' 'f5fpc --stop\n'
unsetopt BEEP

# CPLEX configuration
export PATH=$PATH:/opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x86-64_linux

# OPLRUN configuration
export PATH=$PATH:/opt/ibm/ILOG/CPLEX_Studio201/opl/bin/x86-64_linux
