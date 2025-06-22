#!/bin/sh

# this script allows you to search through a list of predefined URLs using Rofi and open the selected URL in the Brave browser.

BROWSER=brave

file=$(ls $HOME/.config/surfraw/advance | rofi -dmenu -p "Search" -i)

if [[ "$file" == "" ]]; then
	exit 0
fi

url=$(cat $HOME/.config/surfraw/advance/$file | rofi -dmenu -p "Search" -i)

if [[ "$url" != "" ]]; then
	$BROWSER "$url"
fi
