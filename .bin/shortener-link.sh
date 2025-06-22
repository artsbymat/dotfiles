#!/bin/sh

# s.id shortener url

source $HOME/.bin/sid-env

shorten_url() {
	local long_url=$1
	local api_url="https://api.s.id/v1/links"

	response=$(curl -s --location --request POST "$api_url" \
		--header "X-Auth-Id: $X_Auth_Id" \
		--header "X-Auth-Key: $X_Auth_Key" \
		--header "Content-Type: application/json" \
		--data-raw "{
	           \"long_url\": \"$long_url\"
	       }")

	short_code=$(echo "$response" | grep -oP '"short":"\K[^"]+')
	error_msg=$(echo "$response" | grep -oP '"message":"\K[^"]+')

	if [ -n "$short_code" ]; then
		short_url="https://s.id/$short_code"
		echo "Berhasil dibuat: $short_url"

		# Copy to clipboard
		if [ -x "$(command -v pbcopy)" ]; then
			echo -n "$short_url" | pbcopy
			echo "✅ Tersalin ke clipboard (macOS)"
		elif [ -x "$(command -v wl-copy)" ]; then
			echo -n "$short_url" | wl-copy
			echo "✅ Tersalin ke clipboard (Linux/wl-copy)"
		elif [ -x "$(command -v xclip)" ]; then
			echo -n "$short_url" | xclip -selection clipboard
			echo "✅ Tersalin ke clipboard (Linux/xclip)"
		elif [ -x "$(command -v xsel)" ]; then
			echo -n "$short_url" | xsel -b
			echo "✅ Tersalin ke clipboard (Linux/xsel)"
		else
			echo "⚠️ Gagal copy ke clipboard: Install xclip/xsel (Linux) atau pbcopy (macOS)"
		fi
	else
		echo "Gagal mempersingkat URL. Pesan error: $error_msg"
		echo "Respons lengkap: $response"
	fi
}

# help function
if [ $# -lt 1 ]; then
	echo "Penggunaan: $0 <long_url>"
	exit 1
fi

shorten_url "$1" "$2" "$3"
