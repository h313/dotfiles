# Start X at login
eval (python -m virtualfish)
thefuck --alias | source

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end
