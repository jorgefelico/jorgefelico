#!/bin/sh

# Stop any running instance
killall waybar

if [[ $USER = "jorge" ]]; then
  waybar -c ~/dotfiles/waybar/config.jsonc -s ~/dotfiles/waybar/style.css
else
  waybar &
fi
