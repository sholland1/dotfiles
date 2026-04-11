export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

OS=$(uname -s)
if [[ "$OS" == "Linux" ]]; then
    export XDG_SESSION_TYPE=x11
    export XDG_CURRENT_DESKTOP=dwm

    # start graphical server if wm not already running
    [ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
elif [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

