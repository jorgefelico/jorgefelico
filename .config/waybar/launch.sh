#!/bin/sh

# Stop any running instance
killall waybar

if [[ $USER = "jorge" ]]; then
  waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
else
  waybar &
fi
