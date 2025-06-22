#!/bin/sh

updateicon() {
	echo "$1" >/tmp/gamemodeicon
	pkill -RTMIN+2 waybar
}

enable_gamemode() {
	hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
	notify-send "Game Mode" "Game Mode is now enabled"
	updateicon "🎮"
}

disable_gamemode() {
	hyprctl reload
	notify-send "Game Mode" "Game Mode is now disabled"
	updateicon ""
}

get_status() {
	HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
	if [ "$HYPRGAMEMODE" = 1 ]; then
		echo "Game Mode is OFF"
		return 1
	else
		echo "Game Mode is ON"
		return 0
	fi
}

case "$1" in
on)
	enable_gamemode
	;;
off)
	disable_gamemode
	;;
toggle)
	HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
	if [ "$HYPRGAMEMODE" = 1 ]; then
		enable_gamemode
	else
		disable_gamemode
	fi
	;;
status)
	get_status
	;;
*)
	echo "Usage: $0 {on|off|toggle|status}"
	exit 1
	;;
esac

exit 0
