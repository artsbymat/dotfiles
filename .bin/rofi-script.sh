#!/bin/sh

# list of scripts
# Dependencies: rofi, jq

LIST='''
[
    ["Arti kata dari KBBI", "kbbi-notify.sh"],
    ["CRUD Bookmarks", "rofi-crud-bookmarks.sh"],
    ["Calculator / Convert Number", "rofi-calc.sh"],
    ["Color Picker", "rofi-colorpicker.sh"],
    ["Create QRCode", "create-qrcode.sh"],
    ["Filter Blue Light Toggle", "hyprsunset-toggle.sh"],
    ["Open Personal Password Manager", "rofi-keepassxc.sh"],
    ["Pastebin Clipboard", "pastebin-clipboard.sh"],
    ["Play with mpv", "play-with-mpv.sh"],
    ["Pomodoro", "rofi-pomo.sh"],
    ["Run PS2 Games", "rofi-ps2.sh"],
    ["Screenkey", "screenkey-toggle.sh"],
    ["Send Clipboard to Telegram", "bot-tele.sh clipboard"],
    ["Simple Screen Record", "rofi-record.sh"],
    ["Task", "rofi-kill.sh"],
    ["Toggle Gamemode", "game-mode.sh toggle"],
    ["Translate CLI", "rofi-translate.sh"],
    ["Weather Today", "weather-today.sh"]
]
'''

label=$(echo $LIST | jq -r "sort | .[][0]" | rofi -dmenu -p "Scripts" -i)
exec $(echo $LIST | jq -r ".[] | select(.[0] == \"$label\") | .[1]")
