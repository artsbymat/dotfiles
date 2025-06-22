#!/bin/sh

BROWSER=brave

cp ~/.config/BraveSoftware/Brave-Browser/Default/History /tmp/BraveHistoryCopy

# get title and URL from Brave history
history=$(sqlite3 /tmp/BraveHistoryCopy "SELECT title || '|' || url FROM urls ORDER BY last_visit_time DESC")

# Show history in rofi
select=$(echo "$history" | rofi -dmenu -i -p "History" -kb-row-select "Tab" -kb-element-next "")

# Get the URL from the selected item
url=$(echo "$select" | awk -F'|' '{print $NF}')

# If a URL is selected, open it in the browser
if [ -n "$url" ]; then
	$BROWSER "$url"
fi
