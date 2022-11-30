#!/bin/bash
CLIPBOARD_CMD="wl-copy"
GRAB_IMAGE_CMD="grim"
SELECT_REGION_CMD="slurp"
IM_CONVERT_CMD="convert"
GM_CONVERT_CMD="gm"

# wl-copy is required - check if it is available
if ! [[ -x "$(command -v $CLIPBOARD_CMD)" ]]; then
    echo "error: required command '${CLIPBOARD_CMD}' not found"
    exit
fi
# grim is required - check if it is available
if ! [[ -x "$(command -v $GRAB_IMAGE_CMD)" ]]; then
    echo "error: required command '${GRAB_IMAGE_CMD}' not found"
    exit
fi
# slurp is required - check if it is available
if ! [[ -x "$(command -v $SELECT_REGION_CMD)" ]]; then
    echo "error: required command '${SELECT_REGION_CMD}' not found"
    exit
fi
# either imagemagick or graphicsmagick is required for convert - check if one of it is available and use it
if [[ -x "$(command -v $IM_CONVERT_CMD)" ]]; then
    CONVERT_CMD_TO_USE="convert"
elif [[ -x "$(command -v $GM_CONVERT_CMD)" ]]; then
    CONVERT_CMD_TO_USE="gm convert"
else
    echo "error: required command '${IM_CONVERT_CMD}|${GM_CONVERT_CMD}' not found"
    exit
fi

$GRAB_IMAGE_CMD -g "$($SELECT_REGION_CMD -p)" -t ppm - \
    | $CONVERT_CMD_TO_USE - -format '%[pixel:p{0,0}]' txt:- \
    | grep -Eo "#[0-9ABCDEF]{6}" \
    | tee /dev/tty \
    | tr -d "\n" \
    | $CLIPBOARD_CMD
