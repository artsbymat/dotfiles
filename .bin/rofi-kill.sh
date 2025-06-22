#!/bin/sh

# This script show list of processes and allows you to kill them using Rofi.

ps -ef | sed 1d | rofi -dmenu -i -p "Task Man" "$@" | awk '{print $2}' | xargs kill -${1:-9}
