#!/bin/sh

# Dependencies: rofi, wf-recorder, ffmpeg

# Check if dependencies are installed
dependencies="rofi wf-recorder slurp"
for dep in $dependencies; do
    if ! command -v $dep &> /dev/null; then
        echo "$dep is not installed"
        exit 1
    fi
done

updateicon() {
	echo "$1" > /tmp/recordingicon
	pkill -RTMIN+1 waybar
}

LOCATION=~/Videos/screenrecord
NAME=$(date +%Y%m%d%H%M%S).mp4

if [ ! -d ~/Videos/screenrecord ]; then
    mkdir -p ~/Videos/screenrecord
fi

# Cek apakah sudah record
if pgrep -x "wf-recorder" > /dev/null
then
    STOPPED=$(echo -e "Yes\nNo" | rofi -dmenu -p "Recording stopped. Do you want to save the recording?")

    if [ $STOPPED == "Yes" ]
    then
        pkill wf-recorder
        notify-send "Recording saved" "Recording saved to $LOCATION/$NAME"
        updateicon ""
    fi
    exit 1
fi

# Options
SELECTED=$(echo -e "Record screen only\nRecord screen with mic\nRecord screen with media\nRecord screen area" | rofi -dmenu -p "Select recording mode")

# get default device
device=$(wpctl status | grep "Default Configured Devices" -A 2 | grep "Audio/Source" | awk '{print $3}')


case $SELECTED in
"Record screen only")
    updateicon "🔴"
    wf-recorder --framerate 30 --file=$LOCATION/$NAME
	;;
"Record screen with mic")
    updateicon "🔴 🎙️"
    wf-recorder --framerate 30 --audio=$device --file=$LOCATION/$NAME
	;;
"Record screen with media")
    updateicon "🔴 🔉"
	wf-recorder --framrate 30 --audio=$device.monitor --file=$LOCATION/$NAME
	;;
"Record screen area")
    updateicon "🔴 🔲"
	wf-recorder -g "$(slurp)" --framrate 30 --file=$LOCATION/$NAME
	;;
esac

