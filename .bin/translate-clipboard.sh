#!/bin/sh

# Show notification with the translation of the clipboard content

text=$(wl-paste)

if [ -z "$text" ]; then
	exit 0
fi

trans -brief :id "$text" | wl-copy

notify-send "Translation" "$(wl-paste)"
