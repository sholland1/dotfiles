#!/bin/sh

OS=$(uname -s)

# Path to your oh-my-zsh installation.
if [[ "$OS" == "Linux" ]]; then
    export ZSH=/usr/share/oh-my-zsh
elif [[ "$OS" == "Darwin" ]]; then
    export ZSH=$HOME/.oh-my-zsh
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo fzf fzf-tab fancy-ctrl-z zsh-syntax-highlighting)

# User configuration

# Compilation flags
if [[ "$OS" == "Linux" ]]; then
    export ARCHFLAGS="-arch x86_64"
elif [[ "$OS" == "Darwin" ]]; then
    export ARCHFLAGS="-arch arm64"
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [ ! -d "$ZSH_CACHE_DIR" ]; then
    mkdir "$ZSH_CACHE_DIR"
fi

set -a; source "$HOME/.env"; set +a
source "$ZSH/oh-my-zsh.sh"
source "$HOME/bin/cmd-assistant.plugin.zsh"
source "$HOME/bin/with-spinner.zsh"

# remove all aliases
unalias -a

replace() {
    rg -l "$1" | xargs sed -i '' "s/$1/$2/g"
}

alias v=$EDITOR
alias f='$FILE .'
alias ls='eza --icons=always --group-directories-first -la'
alias tree='eza --icons=always --group-directories-first --tree'
alias cloc=tokei
alias fetch=fastfetch

GIT_ENV='GIT_DIR=$HOME/dotfiles.git GIT_WORK_TREE=$HOME'
alias config=$USR_BIN/'git --git-dir="$HOME/dotfiles.git" --work-tree="$HOME"'
alias lazyconfig=$USR_BIN/'lazygit --git-dir="$HOME/dotfiles.git" --work-tree="$HOME"'
alias fconfiglog="$GIT_ENV fgitlog"
alias git-spp="$USR_BIN/git stash && $USR_BIN/git pull && $USR_BIN/git stash pop"
alias config-spp='config stash && config pull && config stash pop'
alias gs='git status'

alias notes='vproj ~/OneDrive/Documents/Notes notes'
alias dotfiles='vdotfiles ~ dotfiles'
alias scripts='vdotfiles ~/bin scripts'
alias nvimconfig='vdotfiles ~/.config/nvim nvimconfig'

