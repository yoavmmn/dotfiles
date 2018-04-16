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

_load_weather() {
  # geo -g - get geolocation data
  # head -3 - get only the first 3 lines
  # tail -r - reverse lines order
  # awk 'NR % 2 == 1' - keep only the first and third lines(city and country) the second line is region, not necessary
  # sed 'N;s/\n/, /;' - remove new-lines and concating to a string like "Tel Aviv, Israel"
  # weather_location// /%20 - replacing spaces to url encoded spaces
  weather_location="$(geo -g | head -3 | tail -r | awk 'NR % 2 == 1' | sed 'N;s/\n/, /;')"
  weather_location="${weather_location// /%20}"

  # check for internet connection
  wget -q --spider http://google.com

  if [ $? -eq 0 ]; then
    curl -s "http://wttr.in/$weather_location\?0TmQ" > "$TMP_WEATHER_FILE"
    echo "$EPOCHSECONDS" >> "$TMP_WEATHER_FILE"
  fi
}


# Weather data
weather_segment() {
  local -r TMP_WEATHER_FILE="$HOME/.tmux/weather.tmp"
  local -r HOT_POINT="17"
  local -r REFRESH_RATE=$(( 5 * 60 ))
  local -r hours="$(date +'%H')"

  if [ ! -f "$TMP_WEATHER_FILE" ]; then
    _load_weather
  fi

  local epoch; epoch="$(tail -n 1 "$TMP_WEATHER_FILE")"
  local delta; delta=$(( EPOCHSECONDS - epoch ))

  # update data every 20 minutes
  if [[ $delta -gt $REFRESH_RATE ]]; then
    _load_weather
  fi

  local weather="$(cat "$TMP_WEATHER_FILE" | grep -o "[0-9]* °C")"
  local temprature=$(echo "$weather" | grep -o "[0-9]*")
  local weather_icon="❆"
  local weather_color="blue"

  if [ "$temprature" -gt "$HOT_POINT" ]; then
    weather_icon="#[bold]☀"
    weather_color="yellow"
  fi

  if [[ "$hours" -ge "20" || "$hours" -le "05" ]]; then
    weather_icon="☾"
    weather_color="white"
  fi  

  tm_segment "$weather_icon" "$weather_color" "$weather"
  tm_divider
}

# Bettery status
battery_segment() {
  if [[ $(command -v pmset) ]]; then
    battery_percentage="$(pmset -g batt | awk '{print $3}' | grep '%')"
    battery_status="$(pmset -g batt | awk '{print $4}' | grep 'char')"
    battery_color="colour28"

    [[ $battery_status == 'discharging;' ]] && battery_color="colour214"

    tm_segment "" "$battery_color" "${battery_percentage%?}"
    tm_divider
  fi
}

# Date and time
date_segment() {
  tm_segment "" "colour245" "$(date +'%B %d, %H:%M')"
  tm_divider
}

# Machine name
host_segment() {
  tm_segment "" "blue" "#h"
}

weather_segment
battery_segment
date_segment
host_segment