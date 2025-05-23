#!/bin/sh
# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Extra plugins installed with pacman

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo fzf fzf-tab fancy-ctrl-z)

# User configuration

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS

ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
if [ ! -d "$ZSH_CACHE_DIR" ]; then
    mkdir "$ZSH_CACHE_DIR"
fi

set -a; source "$HOME/.env"; set +a
source "$ZSH/oh-my-zsh.sh"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$HOME/bin/cmd-assistant.plugin.zsh"
source "$HOME/bin/frepl.plugin.zsh"

# remove all aliases
unalias -a

alias v=$EDITOR
alias f='$FILE .'
alias ls='eza --icons=always --group-directories-first -l'
alias tree='eza --icons=always --group-directories-first --tree'
alias cloc=tokei
alias fetch=fastfetch

GIT_ENV='GIT_DIR=$HOME/dotfiles.git GIT_WORK_TREE=$HOME'
alias config='/usr/bin/git --git-dir="$HOME/dotfiles.git" --work-tree="$HOME"'
alias lazyconfig='/usr/bin/lazygit --git-dir="$HOME/dotfiles.git" --work-tree="$HOME"'
alias fconfiglog="$GIT_ENV fgitlog"
alias git-spp='/usr/bin/git stash && /usr/bin/git pull && /usr/bin/git stash pop'
alias config-spp='config stash && config pull && config stash pop'

alias notes='vproj ~/OneDrive/Documents/Notes notes'
alias dotfiles='vdotfiles ~ dotfiles'
alias scripts='vdotfiles ~/bin scripts'
alias nvimconfig='vdotfiles ~/.config/nvim nvimconfig'
