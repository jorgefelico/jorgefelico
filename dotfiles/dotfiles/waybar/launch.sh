#!/bin/sh

# Stop any running instance
killall waybar

if [[ $USER = "jorge" ]]
then
    waybar -c ~/dotfiles/waybar/myconfig -s ~/dotfiles/waybar/style.css
else
    waybar &
fi
