# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh/

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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(archlinux git vi-mode) # sudo


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

(cat ~/.cache/wal/sequences &)
vproj () {
    pushd $1
    $EDITOR -S Session.vim
    popd
}
alias v='$EDITOR'
alias vv='$EDITOR ~/dotfiles/.config/nvim/init.vim'
alias vz='$EDITOR ~/dotfiles/.zshrc'
alias vk='$EDITOR ~/dotfiles/.config/sxhkd/sxhkdrc'
alias vw='$EDITOR ~/dotfiles/.spectrwm.conf'
alias vf='$EDITOR ~/dotfiles/.config/vifm/vifmrc'
alias vc='$EDITOR ~/dotfiles/.compton.conf'
alias vt='$EDITOR ~/dotfiles/.config/termite/config'
alias ve='$EDITOR ~/dotfiles/.config/mutt/muttrc'
alias vs='sudo $EDITOR /etc/pulse/default.pa'
alias cd.='cd ~/dotfiles'
alias cdn='cd ~/OneDrive/Documents/Notes'
alias clip='xsel'
alias cloc='tokei'
alias notes='vproj ~/OneDrive/Documents/Notes'
alias dotfiles='vproj ~/dotfiles'
alias gbtile='WINEARCH=win32 WINEPREFIX=~/wine/gbtiles wine ~/wine/gbtiles/drive_c/Program\ Files/gbtd/GBTD.EXE &'
alias gbmap='WINEARCH=win32 WINEPREFIX=~/wine/gbtiles wine ~/wine/gbtiles/drive_c/Program\ Files/gbmb/GBMB.EXE &'

gstat () {
  if [ $1 ]; then
    RESULT=`git log -"$1" --pretty=format:"%h" | tail -1`
    git --no-pager diff "$RESULT" --shortstat
  else
    git log --shortstat --oneline
  fi
}

swap () {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

# --preview="head -$LINES {}"

fhist () {
    print -z $(
        ([ -n "$ZSH_NAME" ] && fc -ln 1 || history) |
            fzf +s --tac |
            sed -r 's/ *[0-9]*\*? *//' |
            sed -r 's/\\/\\\\/g')
}

export HISTCONTROL=ignoreboth:erasedups

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
