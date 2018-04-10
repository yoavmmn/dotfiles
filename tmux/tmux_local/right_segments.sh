#!/usr/bin/env bash

tm_segment() {
  icon=$1
  color=$2
  text=$3

  res=""

  [[ -z $color ]] && color="colour245"

  [[ -n $icon ]] && res+="#[ fg=${color}, noreverse] ${icon}"
  [[ -n $text ]] && res+="#[fg=${color} bg=default, noreverse] ${text} "
  res+="#[bg=default, fg=default]"

  echo -ne "$res"
}

tm_divider() {
  echo -ne "#[fg=colour245]|#[bg=default, fg=default]"
}

# Bettery status
if [[ $(command -v pmset) ]]; then
  battery_percentage="$(pmset -g batt | awk '{print $3}' | grep '%')"
  battery_status="$(pmset -g batt | awk '{print $4}' | grep 'char')"
  battery_color="colour28"

  [[ $battery_status == 'discharging;' ]] && battery_color="colour214"

  tm_segment "" "$battery_color" "${battery_percentage%?}"
  tm_divider
fi

# Date and time
tm_segment "" "colour245" "$(date +'%d %b %Y %H:%M')"
tm_divider

# Machine name
tm_segment "" "blue" "#h"
