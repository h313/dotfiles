# Start X at login
if status is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
	set -gx SSH_AUTH_SOCK (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh | grep "^SSH_AUTH_SOCK" | awk -F "=" '{print $2}')
  	exec sway
  end
end
