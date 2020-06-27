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
plugins=(git vi-mode) # sudo


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
source ~/.cache/wal/colors.sh

vproj () {
    pushd $1 > /dev/null
    $EDITOR -S Session.vim
    popd > /dev/null 2>&1
}

alias v='$EDITOR'
alias vifm='$FILE'
alias tig='tig status'
alias cloc='tokei'

alias cdn='cd ~/OneDrive/Documents/Notes'

GIT_ENV='GIT_DIR=$HOME/dotfiles.git GIT_WORK_TREE=$HOME'
alias config="$GIT_ENV /usr/bin/git"
alias contig="$GIT_ENV /usr/bin/tig status"
alias fconfiglog="$GIT_ENV fgitlog"

alias notes='vproj ~/OneDrive/Documents/Notes'
alias dotfiles='vproj ~'
alias scripts='vproj ~/bin'

WINE_CMD='WINEARCH=win32 WINEPREFIX=~/wine/gbtiles wine ~/wine/gbtiles/drive_c/Program\ Files'
alias gbtile="$WINE_CMD/gbtd/GBTD.EXE &"
alias gbmap="$WINE_CMD/gbmb/GBMB.EXE &"

gh-clone () {
    git clone "https://{$2:-github.com}/$1"
}

swap () {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

fgitlog () {
    STATS='git --no-pager diff --shortstat'
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --tiebreak=index --bind=ctrl-s:toggle-sort \
        --preview "(grep -o '[a-f0-9]\{7\}' | xargs -I% sh -c '$STATS % HEAD;$STATS %^ %') << 'FZF-EOF'
            {}
FZF-EOF" \
        --preview-window=up:2 \
        --bind "enter:execute:
                  (grep -o '[a-f0-9]\{7\}' |
                  xargs -I% sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
FZF-EOF"
}

fproj () {
    RESULT=`ls ~/Projects | fzf --preview 'ls -a ~/Projects/{}'`
    [ $RESULT ] && vproj ~/Projects/$RESULT
}

fhist () {
    print -z $(
        ([ $ZSH_NAME ] && fc -ln 1 || history) |
            fzf +s --tac |
            sed -r 's/ *[0-9]*\*? *//' |
            sed -r 's/\\/\\\\/g')
}

frepl () {
    RESULT=`echo "REPL - $1 {}" | fzf --print-query --phony \
        --bind 'alt-h:backward-char,alt-l:forward-char' \
        --preview "$1 {q}" --preview-window=down:99% | head -1`
    if [ $RESULT ]; then
        echo -n "$1 '$RESULT'" | xsel
        echo "Copied '$1 '$RESULT'' to clipboard."
    fi
}

export HISTCONTROL=ignoreboth:erasedups

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
