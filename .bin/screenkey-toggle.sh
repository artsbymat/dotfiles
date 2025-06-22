#!/bin/sh

# Toggle screenkey tool

if pgrep -x "showmethekey-gt" >/dev/null; then
  pkill showmethekey-gt
else
  showmethekey-gtk --active --no-app-win --no-clickable
fi
