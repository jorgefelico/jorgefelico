#!/usr/bin/env bash

timeout 2 playerctl metadata --format '{{duration(position)}}/{{duration(mpris:length)}}' 2>/dev/null
