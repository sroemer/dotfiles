#!/bin/bash
CLIPBOARD_COMMAND="wl-copy"
GRIM_COMMAND="grim"
SLURP_COMMAND="slurp"
IM_CONVERT_COMMAND="convert"
GM_CONVERT_COMMAND="gm"

# wl-copy is required - check if it is available
if ! [[ -x "$(command -v $CLIPBOARD_COMMAND)" ]]; then
    echo "error: required command '${CLIPBOARD_COMMAND}' not found"
    exit
fi
# grim is required - check if it is available
if ! [[ -x "$(command -v $GRIM_COMMAND)" ]]; then
    echo "error: required command '${GRIM_COMMAND}' not found"
    exit
fi
# slurp is required - check if it is available
if ! [[ -x "$(command -v $SLURP_COMMAND)" ]]; then
    echo "error: required command '${SLURP_COMMAND}' not found"
    exit
fi
# either imagemagick or graphicsmagick is required for convert - check if one of it is available and use it
if [[ -x "$(command -v $IM_CONVERT_COMMAND)" ]]; then
    grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | grep -Eo "#[0-9ABCDEF]{6}" | tr -d "\n" | $CLIPBOARD_COMMAND
elif [[ -x "$(command -v $GM_CONVERT_COMMAND)" ]]; then
    grim -g "$(slurp -p)" -t ppm - | gm convert - -format '%[pixel:p{0,0}]' txt:- | grep -Eo "#[0-9ABCDEF]{6}" | tr -d "\n" | $CLIPBOARD_COMMAND
else
    echo "error: required command '${IM_CONVERT_COMMAND}|${GM_CONVERT_COMMAND}' not found"
    exit
fi
