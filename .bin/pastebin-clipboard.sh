#!/bin/sh

# This script takes the content from the clipboard, uploads it to 0x0.st, and copies the link back to the clipboard.

# Get the clipboard content
content=$(wl-paste)

# Upload the content to 0x0.st
link=$(echo "$content" | curl -F 'file=@-' 0x0.st)

# Copy the link to the clipboard
echo "$link" | wl-copy

# Notify the user
notify-send "Link Copied" "$link"

# Open the link in the default web browser
xdg-open "$link"
