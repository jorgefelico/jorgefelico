#!/usr/bin/env bash

zscroll -l 20 \
  --delay 0.3 \
  --update-check true \
  "timeout 2 playerctl metadata --format '{{title}} - {{artist}}'" 2>/dev/null

wait
