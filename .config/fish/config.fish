# Start X at login
source /etc/modules/init/fish
source /etc/modules/init/fish_completion

thefuck --alias | source
set --export VIRTUAL_ENV_DISABLE_PROMPT 1

set fish_greeting

starship init fish | source
