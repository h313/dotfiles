# Start X at login
thefuck --alias | source

if test -n "$DESKTOP_SESSION"
    set (gnome-keyring-daemon --start | string split "=")
end

