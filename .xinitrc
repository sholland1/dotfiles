variety &
sxhkd &
setxkbmap -option caps:swapescape &
([ "$(xset q | grep Num | awk '{print $8}')" == "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 65 &
compton &

exec spectrwm
