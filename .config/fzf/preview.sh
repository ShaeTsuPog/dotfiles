#!/usr/bin/env bash
# ~/.config/fzf/preview.sh

# Capture input and clean ANSI codes from eza
CLEAN_PATH=$(printf "%s" "$1" | sed 's/\x1b\[[0-9;]*m//g' | awk '{print $1}')

# Early exit if file doesn't exist
[[ ! -e "$CLEAN_PATH" ]] && exit 0

# Directory handling
if [[ -d "$CLEAN_PATH" ]]; then
    eza --icons=always --color=always --tree --level=2 "$CLEAN_PATH"
    exit 0
fi

MIME=$(file --mime-type -b "$CLEAN_PATH")

case "$MIME" in
    image/*)
        # Clear and render in one go
        kitty +kitten icat --transfer-mode=file --stdin=no --clear --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$CLEAN_PATH" 2>/dev/null
        ;;
    video/*)
        THUMB="/tmp/$(basename "$CLEAN_PATH").jpg"
        [[ ! -f "$THUMB" ]] && ffmpegthumbnailer -i "$CLEAN_PATH" -o "$THUMB" -s 0 -q 5 2>/dev/null
        kitty +kitten icat --transfer-mode=file --stdin=no --clear --place="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0" "$THUMB" 2>/dev/null
        ;;
    *)
        # Always clear before showing text to prevent image ghosts
        kitty +kitten icat --clear --stdin=no 2>/dev/null
        bat --color=always --style=numbers --theme=ansi "$CLEAN_PATH" 
        ;;
esac

