#!/bin/bash


TEMP_IMG="/tmp/pocr_screenshot_$(date +%s).png"
TEMP_TXT="/tmp/pocr_output_$(date +%s).txt"

command -v slop >/dev/null 2>&1 || { echo >&2 "Error: slop is not installed. Aborting."; exit 1; }
command -v scrot >/dev/null 2>&1 || { echo >&2 "Error: scrot is not installed. Aborting."; exit 1; }
command -v tesseract >/dev/null 2>&1 || { echo >&2 "Error: tesseract is not installed. Aborting."; exit 1; }
command -v xclip >/dev/null 2>&1 || { echo >&2 "Error: xclip is not installed. Aborting."; exit 1; }

SLOP_GEOMETRY=$(slop -n -f "%x,%y,%w,%h" 2>/dev/null)

if [ -z "$SLOP_GEOMETRY" ]; then
    echo "Screenshot selection cancelled."
    exit 1
fi


scrot -a "$SLOP_GEOMETRY" "$TEMP_IMG"
if [ ! -f "$TEMP_IMG" ]; then
    echo "Screenshot capture failed after selection."
    exit 1
fi

tesseract "$TEMP_IMG" stdout > "$TEMP_TXT" 2>/dev/null

if [ ! -s "$TEMP_TXT" ]; then
    echo "No text found in the selected area."
    rm -f "$TEMP_IMG" "$TEMP_TXT"
    exit 1
fi


cat "$TEMP_TXT" | xclip -selection clipboard
command -v notify-send >/dev/null 2>&1 && notify-send "pOCR" "Text copied to clipboard!"

rm -f "$TEMP_IMG" "$TEMP_TXT"

exit 0




