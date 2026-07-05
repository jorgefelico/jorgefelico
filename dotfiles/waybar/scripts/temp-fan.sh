#!/usr/bin/env bash

# Auto-detect coretemp hwmon by following the device symlink
hwmon_base="/sys/class/hwmon"
temp_val=""
fan_val=""

for hwmon in "$hwmon_base"/*/; do
  # Detect coretemp for temperature
  if [ -z "$temp_val" ]; then
    if [ -L "${hwmon}device" ]; then
      dev=$(readlink -f "${hwmon}device" 2>/dev/null)
      if echo "$dev" | grep -q "coretemp"; then
        if [ -r "${hwmon}temp1_input" ]; then
          temp_val=$(( $(<"${hwmon}temp1_input") / 1000 ))
        fi
      fi
    fi
  fi

  # Detect fan from any hwmon that has a fan1_input
  if [ -z "$fan_val" ] && [ -r "${hwmon}fan1_input" ]; then
    fan_val=$(<"${hwmon}fan1_input")
  fi

  [ -n "$temp_val" ] && [ -n "$fan_val" ] && break
done

# Fallback defaults
: "${temp_val:=0}"
: "${fan_val:=0}"

# Temperature class
temp_class="none"
if [ "$temp_val" -ge 80 ]; then
  temp_class="critical"
elif [ "$temp_val" -ge 70 ]; then
  temp_class="warning"
fi

# Fan class
fan_class="none"
if [ "$fan_val" -ge 5000 ]; then
  fan_class="fast"
elif [ "$fan_val" -ge 4000 ]; then
  fan_class="medium"
elif [ "$fan_val" -ge 3000 ]; then
  fan_class="slow"
fi

echo "{\"text\": \"󰔏 ${temp_val}°C 󰈐 ${fan_val}\", \"class\": \"${temp_class}\", \"tooltip\": \"CPU: ${temp_val}°C | Fan: ${fan_val} RPM\"}"
