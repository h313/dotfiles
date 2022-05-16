#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export DOTNET_CLI_TELEMETRY_OPTOUT=1

export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)

alias kys='poweroff'
alias grep='rg --color=auto'
alias ls='exa --color=auto --group-directories-first'
alias mkdir='mkdir -p'

alias vim='nvim'
alias vimdiff='nvim -d'
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'

eval "$(thefuck --alias)"

