export PATH=$HOME/.local/bin:$HOME/bin:$CARGO_HOME/bin:$XDG_DATA_HOME/npm/bin:$PATH
export FILE="$XDG_CONFIG_HOME/vifm/scripts/vifmrun"

OS=$(uname -s)
if [[ "$OS" == "Linux" ]]; then
    export USR_BIN=/usr/bin
    export TERM=$USR_BIN/alacritty
    export NODE_PATH=$NODE_PATH:$(npm root -g)
elif [[ "$OS" == "Darwin" ]]; then
    export USR_BIN=/opt/homebrew/bin
fi

export EDITOR=$USR_BIN/nvim
export GIT_EDITOR=$USR_BIN/nvim
export BROWSER=$USR_BIN/firefox

export FZF_DEFAULT_OPTS='--exact --tiebreak=begin --reverse --cycle --color=16 --height 100%
    --bind=alt-j:down,alt-k:up,ctrl-a:select-all,ctrl-z:deselect-all,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-down:preview-down,alt-up:preview-up'
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude .git || find -type f'
#export FZF_COMPLETION_TRIGGER='##'

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export GOPATH="$XDG_DATA_HOME/go"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zshcompdump"

