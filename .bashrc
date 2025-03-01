#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

GPG_TTY=$(tty)
export GPG_TTY

alias grep='rg --color=auto'
alias ls='eza --color=auto --group-directories-first'
alias mkdir='mkdir -p'

alias kys='poweroff'
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'

eval "$(thefuck --alias)"

