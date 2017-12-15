tell application "Safari" to activate

tell application "System Events"
  tell process "Safari"
    keystroke "netflix.com"
    keystroke return
  end tell
end tell