# start graphical server if wm not already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x spectrwm >/dev/null && exec startx
