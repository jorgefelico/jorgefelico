#!/usr/bin/env bash

# 1. Grab the CPU temp using your existing auto-detection logic
hwmon_base="/sys/class/hwmon"
temp_val=""

for hwmon in "$hwmon_base"/*/; do
  if [ -z "$temp_val" ]; then
    hwmon_name=$(cat "${hwmon}name" 2>/dev/null)
    if echo "$hwmon_name" | grep -qE "k10temp|coretemp"; then
      if [ -r "${hwmon}temp1_input" ]; then
        temp_val=$(($(cat "${hwmon}temp1_input") / 1000))
        break
      fi
    fi
  fi
done

# 2. Grab the Fan Speed directly from the ACPI interface
# We extract only the line containing "speed" and isolate the number
fan_val=$(awk '/speed:/ {print $2}' /proc/acpi/ibm/fan 2>/dev/null)

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
