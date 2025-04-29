#!/bin/sh
export PATH=$HOME/bin:$HOME/.cargo/bin:$PATH
export NODE_PATH=$NODE_PATH:$(npm root -g)

export TERM=/usr/bin/alacritty
export EDITOR=/usr/bin/nvim
export GIT_EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/firefox
export FILE=~/.config/vifm/scripts/vifmrun

export FZF_DEFAULT_OPTS='--exact --tiebreak=begin --reverse --cycle --color=16
    --bind=alt-j:down,alt-k:up,ctrl-a:select-all,ctrl-z:deselect-all,ctrl-d:half-page-down,ctrl-u:half-page-up,alt-down:preview-down,alt-up:preview-up'
export FZF_DEFAULT_COMMAND='git ls-files --cached --others --exclude .git || find -type f'
#export FZF_COMPLETION_TRIGGER='##'

export _JAVA_AWT_WM_NONREPARENTING=1

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx -dr &

xargs redshift -t 6500:3000 -l <~/.cache/.location &
set-keyboard-settings &

wal -R &
([ "$(xset q | awk '/Num /{print $8}')" = "off" ] && xdotool key Num_Lock) &
picom &
sxhkd &
mpd &
flameshot &

systemctl --user import-environment DISPLAY
clipmenud &
alttab -pk Left -nk Right -vp 1920x1080+0+0 -s 1 -w 1 &

while true; do
  set-status --cpu-mem-disk
  xsetroot -name "$(print-status)"
  sleep 0.5s
done &

while true; do
  dwm > /dev/null
done

