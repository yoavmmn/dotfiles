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
  # corelocationcli - get geolocation data
  # weather_location// /%20 - replacing spaces to url encoded spaces
  weather_location="$(corelocationcli)"
  weather_location="${weather_location// /%20}"

  # check for internet connection
  wget -q --spider http://google.com

  if [ $? -eq 0 ]; then
    curl -s "http://wttr.in/$weather_location?format=1" > "$TMP_WEATHER_FILE"
    echo "$(date +'%s')" >> "$TMP_WEATHER_FILE"
  fi
}


# Weather data
weather_segment() {
  local -r TMP_WEATHER_FILE="$HOME/.tmux/weather.tmp"
  local -r HOT_POINT="17"
  local -r REFRESH_RATE=$(( 60 * 60 )) // 60 minutes
  local -r hours="$(date +'%H')"

  [[ -f "$TMP_WEATHER_FILE" ]] \
    || _load_weather

  local now; now="$(date +'%s')"
  local epoch; epoch="$(tail -n 1 "$TMP_WEATHER_FILE")"
  local delta; delta="$(( now - epoch ))"

  # check if it's time to update the data
  [[ $delta -gt $REFRESH_RATE ]] \
    && _load_weather

  local weather="$(head -n 1 "$TMP_WEATHER_FILE")"
  weather="$(echo "${weather//+}")" 

  tm_segment "" "" "$weather"
  tm_divider
}

# Music
music_segment() {
  [[ $(command -v osascript) ]] \
    || return 1

  spotify="$(osascript "$HOME"/.tmux/applescripts/spotify.scpt)"
  is_playing="$(osascript "$HOME"/.tmux/applescripts/spotify_is_playing.scpt)"

  [[ "$is_playing" == 1 ]] && \
    music_color="#25d34e" || \
    music_color=""

  # Truncate the result
  [[ ${#spotify} -gt 25 ]] && \
    spotify="$(echo "$spotify" | cut -c 1-25)..."

  if [[ -n "$spotify" ]]; then
    tm_segment "" "$music_color" "${spotify}"
    tm_divider
  fi
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

music_segment
weather_segment
battery_segment
date_segment
host_segment