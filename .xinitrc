#!/bin/sh
export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH
export NODE_PATH=$NODE_PATH:$(npm root -g)

export TERM=/usr/bin/alacritty
export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/firefox
export FILE=~/.config/vifm/scripts/vifmrun

export FZF_DEFAULT_OPTS='--reverse --cycle --color=16
    --bind=alt-j:down,alt-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-down:preview-down,alt-up:preview-up'
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude-standard --exclude .git || find -type f'
#export FZF_COMPLETION_TRIGGER='##'

export _JAVA_AWT_WM_NONREPARENTING=1

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

xargs redshift -t 6500:3000 -l <~/.cache/.location &
setxkbmap -option caps:swapescape &
~/.fehbg &
([ "$(xset q | awk '/Num /{print $8}')" = "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 80 &
picom &
sxhkd &
mpd &

IDLEP = 1
IDLEC = 1
TOTALP = 1
TOTALC = 1

while true; do
  IDLEP=$IDLEC
  TOTALP=$TOTALC
  read -r IDLEC TOTALC <<<$(cpu)
  xsetroot -name "$(status $IDLEP $TOTALP $IDLEC $TOTALC)"
  sleep 1s
done &

while true; do
  dwm > /dev/null
done

