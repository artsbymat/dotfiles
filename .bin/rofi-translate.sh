#!/bin/sh

# select source and target languages for translation-cli

source=$(trans -list-all | rofi -dmenu -i -p "Source")
sourceID=$(echo $source | cut -d ' ' -f1)

if [ -z "$sourceID" ]; then
	exit 1
fi

target=$(trans -list-all | rofi -dmenu -i -p "Target")
targetID=$(echo $target | cut -d ' ' -f1)

if [ -z "$sourceID" ]; then
	exit 1
fi

kitty trans -shell -source $sourceID -target $targetID
