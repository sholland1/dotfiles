#!/bin/sh
export PATH=$HOME/bin:/usr/local/bin:$PATH

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

