# Start X at login
if status is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    set -x XCURSOR_THEME "Paper"
    set -x QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -x QT_QPA_PLATFORM wayland-egl
    set -x QT_WAYLAND_FORCE_DPI physical
    set -x ORG_KDE_KWIN_SERVER_DECORATION_MANAGER_MODE_SERVER none
    set -x GDK_BACKEND wayland
    set -x CLUTTER_BACKEND wayland
    set -x SDL_VIDEODRIVER wayland
    set -x _JAVA_AWT_WM_NONREPARENTING 1
    set -x EDITOR nvim
    set -x QT_QPA_PLATFORMTHEME qt5ct
    set -x QT_AUTO_SCREEN_SCALE_FACTOR 1
    set -gx SSH_AUTH_SOCK (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh | grep "^SSH_AUTH_SOCK" | awk -F "=" '{print $2}')
    set -x XCURSOR_SIZE 16
    exec sway
  end
end

thefuck --alias | source
