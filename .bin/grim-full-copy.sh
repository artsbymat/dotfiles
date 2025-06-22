#!/bin/sh

# Take a screenshot with grim, copy it to the clipboard with wl-copy, and save it to a file

LOCATION=~/Pictures/screenshots
NAME=$(date +%Y%m%d%H%M%S).png
grim $LOCATION/$NAME
wl-copy <$LOCATION/$NAME

notify-send --icon=$LOCATION/$NAME "Screenshot copied to clipboard" "Screenshot saved to $LOCATION"
