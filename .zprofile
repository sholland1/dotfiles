export EDITOR="nvim"
export TERMINAL="urxvt"
export BROWSER="waterfox"
export FILE="ranger"

# start graphical server if i3 not already running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
