#!/bin/sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM=/usr/bin/termite
export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/waterfox-classic
export FILE=/usr/bin/vifm

export FZF_DEFAULT_OPTS='--reverse --color=light
    --bind=alt-j:down,alt-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up,down:preview-down,up:preview-up'
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude-standard --exclude .git || find -type f'
#export FZF_COMPLETION_TRIGGER='##'

cat ~/.location | xargs redshift -t 6500:3000 -l &
setxkbmap -option caps:swapescape &
feh --recursive --randomize --bg-fill ~/images/wallpaper &
([ "$(xset q | awk '/Num /{print $8}')" == "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 80 &
compton &
sxhkd &

#exec spectrwm
while true; do
    xsetroot -name "$(status)"
    sleep 2s
done &
while true; do
    dwm > /dev/null
done;

