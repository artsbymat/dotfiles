#/bin/sh

# Hyprland screenshot script
# Dependencies: grim, slurp, jq, satty, yad, dunstify, wl-copy, cloudinary-cli, zbarimg

SELECTED=$(echo -e "Full\nArea\nWindow\nNotes\nDecodeQR" | rofi -dmenu -p "Screenshot")
LOCATION=~/Pictures/screenshots
NAME=$(date +%Y%m%d%H%M%S).png

sleep 0.1

case $SELECTED in
Full)
	grim -t ppm - | satty --filename - --disable-notifications --fullscreen --early-exit --action-on-enter save-to-file --output-filename $LOCATION/$NAME
	reply_action() {
		# rename file
		newname=$(yad --title="Rename Screenshot" --entry --text="Enter new filename:" --entry-text="$NAME" --width=300 --height=100)
		if [ -n "$newname" ]; then
			mv "$LOCATION/$NAME" "$LOCATION/$newname"
			notify-send "Screenshot renamed" "New name: $newname"
		fi
	}
	handle_dismiss() {
		echo 'dissmiss'
	}

	ACTION=$(dunstify --action="default,Reply" --icon="$LOCATION/$NAME" "Screenshot copied to clipboard" "Screenshot saved to $LOCATION, <small>middle click to rename</small>")

	wl-copy <$LOCATION/$NAME

	case "$ACTION" in
	"default")
		reply_action
		;;
	"2")
		handle_dismiss
		;;
	esac
	;;
Area)
	grim -g "$(slurp)" -t ppm - | satty --filename - --disable-notifications --fullscreen --early-exit --action-on-enter save-to-file --output-filename $LOCATION/$NAME
	notify-send --icon=$LOCATION/$NAME "Screenshot copied to clipboard" "Screenshot saved to $LOCATION"
	wl-copy <$LOCATION/$NAME
	;;
Window)
	# FIX: Use hyprctl to get the geometry of the active window
	Geometry=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == "$(hyprctl activewindow -j | jq -r '.workspace.id')\)"" | jq -r ".at,.size" | jq -s "add" | jq '_nwise(4)' | jq -r '"\(.[0]),\(.[1]) \(.[2])x\(.[3])"' | slurp)
	if [ -z "$Geometry" ]; then
		notify-send "No window selected"
		exit 1
	fi
	grim -g "$Geometry" -t ppm - | satty --filename - --fullscreen --output-filename $LOCATION/$NAME
	;;
Notes)
	source $HOME/.local/source/cld/bin/activate
	source $HOME/.bin/cloudinary-env
	grim -g "$(slurp)" -t ppm - | satty --filename - --early-exit --disable-notifications --fullscreen --output-filename $LOCATION/$NAME --action-on-enter save-to-file
	upload=$(cld uploader upload $LOCATION/$NAME folder=NewNotes use_filename=true unique_filename=false | jq -r '.secure_url')
	echo "![$NAME]($upload)" | wl-copy
	notify-send "Screenshot uploaded to cloudinary and link copied to clipboard"
	;;
DecodeQR)
	grim -g "$(slurp)" /tmp/decodeqr.png
	zbarimg /tmp/decodeqr.png | sed -n 's/^QR-Code://p' | wl-copy
	notify-send "QR code decoded" "Text copied to clipboard"
	;;
esac
