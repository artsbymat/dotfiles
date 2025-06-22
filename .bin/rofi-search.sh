#!/bin/sh

BROWSER=brave

select=$(surfraw -elvi | awk -F'-' '{print $1}' | sed '/:/d' | awk '{$1=$1};1' | rofi -dmenu -i -p "Search" -kb-row-select "Tab" -kb-element-next "")

if [[ "$select" != "" ]]; then
	surfraw -browser=$BROWSER $select
fi
