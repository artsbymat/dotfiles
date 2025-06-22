#!/bin/sh

# This script show rofi calculator and copies the result to the clipboard.

rofi -show calc -modi calc -no-show-match -no-sort -calc-command "echo -n '{result}' | wl-copy"
