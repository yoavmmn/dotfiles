macos_magics() {
  echo "[*] Setting up macOS configs..."

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Set the tile size to 47
  defaults write com.apple.dock tilesize -integer 47

  # change screenshot file type to jpeg
  defaults write com.apple.screencapture type jpg
  
  # changes hidden apps icon transparency
  defaults write com.apple.Dock showhidden -bool true

  # compile applescripts
  path="./macos/applescripts"
  scripts=$(ls $path)

  for script in ${scripts[@]}; do
    filename="${script%.*}"
    echo "[*] Compiling $filename AppleScript..."

    if [[ $filename = "netflix" ]]; then
      read -p " - [*] What's your Netflix profile name? " profile

      echo $profile > "$HOME/.netflix_profile"
    fi

    osacompile -o "$filename.app" "$path/$filename.applescript"
  done
}

