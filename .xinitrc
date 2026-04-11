#!/bin/sh
export _JAVA_AWT_WM_NONREPARENTING=1

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx -dr &

xargs redshift -t 6500:3000 -l <"$HOME/.cache/.location" &
set-keyboard-settings &
init-mic &

wal -R &
([ "$(xset q | awk '/Num /{print $8}')" = "off" ] && xdotool key Num_Lock) &
picom &
sxhkd &
mpd &
flameshot &
emote &

systemctl --user import-environment DISPLAY
clipmenud &
alttab -pk Left -nk Right -vp 1920x1080+0+0 -s 1 -w 1 &

while true; do
  set-status --cpu-mem-disk
  xsetroot -name "$(print-status)"
  sleep 0.5s
done &

xrdb -merge $XDG_CACHE_HOME/wal/colors.Xresources
while true; do
  dwm > /dev/null
done

