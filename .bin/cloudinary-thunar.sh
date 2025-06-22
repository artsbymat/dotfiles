#!/bin/sh

# This script uploads an image to cloudinary using Thunar custom action.

if ! ping -q -c 1 -W 2 8.8.8.8 >/dev/null; then
    notify-send "Upload Failed" "No internet connection"
    exit 1
fi

source $HOME/.local/source/cld/bin/activate
source $HOME/.bin/cloudinary-env

upload=$(cld uploader upload "$1" folder=Other use_filename=true unique_filename=false | jq -r '.secure_url')

echo "$upload" | wl-copy

notify-send "Image uploaded to cloudinary" "Link copied to clipboard"
