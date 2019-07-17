cat ~/.location | xargs redshift -l &
setxkbmap -option caps:swapescape &
cat ~/.config/variety/wallpaper/wallpaper.jpg.txt | xargs -I{} feh --bg-fill {} &
sxhkd &
([ "$(xset q | grep Num | awk '{print $8}')" == "off" ] && xdotool key Num_Lock) &
xset s off -dpms &
xset r rate 250 80 &
compton &

exec spectrwm
