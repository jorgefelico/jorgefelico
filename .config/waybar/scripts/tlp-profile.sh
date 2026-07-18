#!/usr/bin/env bash

profile=$(tlp-stat -s 2>/dev/null | grep "TLP profile" | sed 's/.*= //' | cut -d'/' -f1)

case "$profile" in
  performance)
    icon=""
    ;;
  balanced)
    icon=""
    ;;
  power-saver)
    icon=""
    ;;
  *)
    icon=""
    ;;
esac

echo "{\"text\": \"$icon\", \"class\": \"$profile\", \"tooltip\": \"TLP: $profile\"}"
