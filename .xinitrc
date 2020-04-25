cat ~/.location | xargs redshift -t 6500:3000 -l &
setxkbmap -option caps:swapescape &
feh --recursive --randomize --bg-fill ~/images/wallpaper &
sxhkd &
([ "$(xset q | grep Num | awk '{print $8}')" == "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 80 &
compton &

exec spectrwm
