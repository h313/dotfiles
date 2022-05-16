thefuck --alias | source
set --export VIRTUAL_ENV_DISABLE_PROMPT 1

set fish_greeting

alias kys='poweroff'
alias grep='rg --color=auto'
alias ls='exa --color=auto --group-directories-first'
alias mkdir='mkdir -p'

alias vim='nvim'
alias vimdiff='nvim -d'
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'

starship init fish | source
