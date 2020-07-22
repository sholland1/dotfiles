#!/bin/sh
export PATH=$HOME/bin:/usr/local/bin:$PATH
export NODE_PATH=$NODE_PATH:$(npm root -g)

export TERM=/usr/bin/alacritty
export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/waterfox-classic
export FILE=~/.config/vifm/scripts/vifmrun

export FZF_DEFAULT_OPTS='--reverse --cycle --color=16
    --bind=alt-j:down,alt-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up,down:preview-down,up:preview-up'
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude-standard --exclude .git || find -type f'
#export FZF_COMPLETION_TRIGGER='##'

export _JAVA_AWT_WM_NONREPARENTING=1

xargs redshift -t 6500:3000 -l < ~/.cache/.location &
setxkbmap -option caps:swapescape &
~/.local/bin/wal -R -o wal-set-last &
([ "$(xset q | awk '/Num /{print $8}')" = "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 80 &
compton &
sxhkd &
mpd &

while true; do
    xsetroot -name "$(status)"
    sleep 1s
done &

while true; do
    dwm > /dev/null
done;

