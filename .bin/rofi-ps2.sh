#!/bin/sh

# Games directory
DIR="$HOME/games/ps2"

# Get list of PS2 games in the directory
games=$(fd -e iso -e bin . "$DIR")

# Format the list of games for display
games_display=$(echo "$games" | sed "s|$DIR/||")

# Select a game using rofi
selected=$(echo "$games_display" | rofi -dmenu -i -p "Select PS2 Game")

# Check if a game was selected
if [ -z "$selected" ]; then
	exit 1
fi

# Launch the selected game with PCSX2
pcsx2 -nogui -fullscreen "$DIR/$selected"

# TODO: Enable gamemode automatically
