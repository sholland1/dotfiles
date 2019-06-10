xrdb ~/.Xresources &
feh --bg-scale ~/images/garrett-parker-247225-unsplash.jpg &
sxhkd &
setxkbmap -option caps:swapescape &
([ "$(xset q | grep Num | awk '{print $8}')" == "off" ] && xdotool key Num_Lock) &
xset s off -dmps &
xset r rate 250 65 &
compton &

exec spectrwm
