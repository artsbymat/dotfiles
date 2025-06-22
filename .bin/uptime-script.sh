#!/bin/sh

# Show uptime in a human-readable format

uptime_seconds=$(cat /proc/uptime | awk '{print $1}' | cut -d. -f1)

days=$((uptime_seconds / 86400))
remaining_seconds=$((uptime_seconds % 86400))

hours=$((remaining_seconds / 3600))
remaining_seconds=$((remaining_seconds % 3600))

minutes=$((remaining_seconds / 60))

get_label() {
    if [ "$1" -eq 1 ]; then
        echo "$2"
    else
        echo "$3"
    fi
}

parts=()

if [ "$days" -gt 0 ]; then
    day_label=$(get_label "$days" "day" "days")
    parts+=("${days} ${day_label}")
fi

if [ "$hours" -gt 0 ]; then
    hour_label=$(get_label "$hours" "hour" "hours")
    parts+=("${hours} ${hour_label}")
fi

if [ "$minutes" -gt 0 ] || ([ "$days" -eq 0 ] && [ "$hours" -eq 0 ]); then
    minute_label=$(get_label "$minutes" "minute" "minutes")
    parts+=("${minutes} ${minute_label}")
fi

echo "${parts[*]}"
