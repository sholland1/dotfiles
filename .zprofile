export XDG_CURRENT_DESKTOP=dwm
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export GOPATH="$XDG_DATA_HOME/go"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zshcompdump"

# start graphical server if wm not already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
