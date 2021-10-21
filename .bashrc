#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export GEM_PATH=/usr/lib/ruby/gems/2.4.0/
export DOTNET_CLI_TELEMETRY_OPTOUT=1

alias kys=poweroff
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'
alias grep='grep --color=auto'
alias ls='ls --color=auto --group-directories-first -N'
alias ll='ls -l'
alias la='ls -A'
alias lf='ls -F'
alias l.='ls -d .*'
alias lh='ls -lh'
alias lr='ls -R'
alias l='ls'
alias mkdir='mkdir -p'

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

eval "$(thefuck --alias)"

source /etc/modules/init/bash
source /etc/modules/init/bash_completion
source /usr/share/doc/pkgfile/command-not-found.bash

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

