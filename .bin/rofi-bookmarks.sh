#!/bin/sh

# This script show list of bookmarks from custom bookmarks file and opens selected bookmark in Brave browser.
#
BROWSER=brave

select=$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sed '/^#/d' | sed '/^\//d' | sort -n | rofi -dmenu -i -p "Bookmarks" -kb-row-select "Tab" -kb-element-next "")

if [[ "$select" != "" ]]; then
	surfraw -browser=$BROWSER "$select"
fi
