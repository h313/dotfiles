#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export GEM_PATH=/usr/lib/ruby/gems/2.4.0/
export DOTNET_CLI_TELEMETRY_OPTOUT=1

eval $(thefuck --alias)

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


if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

exec fish
