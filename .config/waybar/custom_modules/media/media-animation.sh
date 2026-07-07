#!/usr/bin/env bash

animation_frames=("▂▄▆" "▄▂▆" "▄▆▂" "▆▄▂" "▆▂▄")
cached_status=""

while :; do
  cached_status=$(timeout 2 playerctl metadata --format '{{status}}' 2>/dev/null)

  for _ in $(seq 1 5); do
    for frame in "${animation_frames[@]}"; do
      if [ "$cached_status" == "Playing" ]; then
        echo "$frame"
      elif [ "$cached_status" == "Paused" ]; then
        echo ""
      else
        echo ""
      fi
      sleep 0.2
    done
  done
done
