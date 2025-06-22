#!/bin/sh

# This script uploads an image to 0x0.st using Thunar custom action.

if ! ping -q -c 1 -W 2 8.8.8.8 >/dev/null; then
    notify-send "Upload Failed" "No internet connection"
    exit 1
fi

link=$(curl -F 'file=@-' 0x0.st <$1)

notify-send "File Upload" "Link copied to clipboard: $link"

echo "$link" | wl-copy
xdg-open "$link"
