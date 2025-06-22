#!/bin/sh

# hyprland submap notification script

if [ "$1" == "w" ]; then
	notify-send --urgency=low "Submap Browse" "S: Search\nB: Bookmarks\nH: History\nA: Advance Search\nEsc: Exit" --expire-time=3000
fi

if [ "$1" == "s" ]; then
	notify-send --urgency=low --expire-time=5000 "Submap Search" \
		"W: Brave Browser\nT: Thunar File Manager\nN: Terminal Network Manager\nM: Ncmpcpp Music Player\nB: Bluetui Terminal\nO: Obsidian Note Editor\nE: Emoji Selector\nC: Calculator\nP: Password Manager\nA: Translator\nS: Screenkey\nG: Toggle Game Mode\nL: Auto Layout\nX: Color Picker\nV: Select Color Picker \nQ: Kill Selector"
fi
