#!/bin/bash

fan=$(sensors | awk '/fan1:/ {print $2}')

# Default if no value is found
if [ -z "$fan" ]; then
  fan=0
fi

# Determine the class
if [ "$fan" -lt 3000 ]; then
  class="none"
elif [ "$fan" -lt 4000 ]; then
  class="slow"
elif [ "$fan" -lt 5000 ]; then
  class="medium"
else
  class="fast"
fi

# Output JSON
echo "{\"text\": \"$fan\", \"class\": \"$class\"}"

