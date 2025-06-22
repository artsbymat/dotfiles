#!/bin/sh

# This script uploads an file to telegram using the Telegram Bot API.

set -euo pipefail

### file name and user caption
declare -r user_file=${1:? error ... user_file ?}
declare -r user_caption="${2:-here is your file <b>$user_file</b>}"

if ! [[ -f $user_file ]]; then
	echo "$user_file not found or is not a regular file"
	exit 1
fi

source ./telegram-env

declare -r bot_log_file=~/.cache/bot-telefile.log

### sendDocument -- https://core.telegram.org/bots/api#senddocument
curl -sL \
	-o $bot_log_file \
	-F document=@"$user_file" \
	-F chat_id="$BOT_CHAT_ID" \
	-F parse_mode="HTML" \
	-F caption="$user_caption" \
	-X POST \
	https://api.telegram.org/bot$BOT_TOKEN/sendDocument

### validate the result
declare -r send_doc_result=$(jq '.ok' <$bot_log_file)
if [[ $send_doc_result == 'true' ]]; then
	echo "[Y] done"
else
	declare -r error_description=$(jq '.description' <$bot_log_file)
	echo "[X] error: $error_description"
	exit 1
fi
