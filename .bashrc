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

export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=xim

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export XCURSOR_THEME="Paper"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export QT_QPA_PLATFORM="wayland-egl"
export QT_WAYLAND_FORCE_DPI="physical"
export ORG_KDE_KWIN_SERVER_DECORATION_MANAGER_MODE_SERVER=none
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR=nvim
export TERM=alacritty
export QT_QPA_PLATFORMTHEME=qt5ct
export SSH_AUTH_SOCK=$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh | grep "^SSH_AUTH_SOCK" | awk -F "=" '{print $2}')
export XCURSOR_SIZE=16
export GTK_IM_MODULE=ibus
export QT4_IM_MODULE=xim
export QT_IM_MODULE=xim
export XMODIFIERS="@im=ibus"

[[ $XDG_VTNR -le 2 ]] && tbsm
