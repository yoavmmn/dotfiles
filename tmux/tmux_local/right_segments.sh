#!/usr/bin/env bash

tm_segment() {
  icon=$1
  color=$2
  text=$3

  res=""

  [[ -z $color ]] && color="colour245"

  [[ -n $icon ]] && res+="#[fg=${color}, noreverse] ${icon}"
  [[ -n $text ]] && res+="#[fg=${color} bg=default, noreverse] ${text} "
  res+="#[bg=default, fg=default]"

  echo -ne "$res"
}

tm_divider() {
  echo -ne "#[fg=colour245]|#[bg=default, fg=default]"
}

# Weather data
if [ ! -f ~/.tmux/weather ]; then
  curl -s http://wttr.in/Tel%20Aviv\?0TmQ > ~/.tmux/weather
fi

minutes="$(date +'%M')"
seconds="$(date +'%S')"

# update data every 20 minutes
if [[ "$(($minutes % 5))" = "0" && "$seconds" -gt "00" && "$seconds" -lt "03" ]]; then
  curl -s http://wttr.in/Tel%20Aviv\?0TmQ > ~/.tmux/weather
fi

weather="$(cat ~/.tmux/weather | grep -o "[0-9]* °C")"
temprature=$(echo "$weather" | grep -o "[0-9]*")
hot_point="17"
weather_icon="❆"
weather_color="blue"

if [ "$temprature" -gt "$hot_point" ]; then
  weather_icon="#[size=20]☀"
  weather_color="yellow"
fi

tm_segment "$weather_icon" "$weather_color" "$weather"
tm_divider

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
tm_segment "" "colour245" "$(date +'%B %d, %H:%M')"
tm_divider

# Machine name
tm_segment "" "blue" "#h"
