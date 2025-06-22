#!/bin/sh

# This script checks the status of dunst notifications and returns an icon based on whether notifications are enabled or disabled.

COUNT=$(dunstctl count waiting)
ENABLED=
DISABLED=
if [ $COUNT != 0 ]; then DISABLED=" $COUNT"; fi
if dunstctl is-paused | grep -q "false"; then echo $ENABLED; else echo $DISABLED; fi
