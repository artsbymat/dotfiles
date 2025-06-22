#!/bin/sh

# This script creates a QR code from the clipboard content and saves it to a specified location.

LOCATION=~/Pictures/qr
NAME=$(date +%Y%m%d%H%M%S).png

text=$(wl-paste)

qrencode -o $LOCATION/$NAME "$text"
notify-send "QR code created" "Saved to $LOCATION/$NAME"
