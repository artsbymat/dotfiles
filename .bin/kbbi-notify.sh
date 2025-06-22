#!/bin/sh

# This script fetches the meaning of a word from KBBI and displays it as a notification.

if ! ping -q -c 1 -W 1 google.com >/dev/null; then
	notify-send "Tidak ada koneksi internet"
	exit 1
fi

API="https://kbbisc.vercel.app/v1/"
params="arti?kata="
clipboard=$(wl-paste)

message=$(curl -s $API$params$clipboard | jq -r '.arti')

notify-send "$clipboard" "$message"
