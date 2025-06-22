#!/bin/sh

# This script provides a power menu using Rofi.
# Dependencies: hyprlock, rofi

selected=$(echo -e "Lock\nShutdown\nReboot\nSuspend\nLogout" | rofi -dmenu -i -p "Power Menu")

case $selected in
Lock)
	hyprlock
	;;
Shutdown)
	brightnessctl --save
	bot-tele.sh battery-remaining && systemctl poweroff
	;;
Reboot)
	brightnessctl --save
	systemctl reboot
	;;
Suspend)
	systemctl suspend
	;;
Logout)
	brightnessctl --save
	hyprctl dispatch exit
	;;
esac
