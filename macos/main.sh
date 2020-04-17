macos_magics() {
  echo "[*] Setting up macOS configs..."

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Minimize to application icon in dock
  defaults write com.apple.dock minimize-to-application -bool true

  # Set dock orientation to left
  defaults write com.apple.dock orientation -string left

  # Set the tile size to 47
  defaults write com.apple.dock tilesize -integer 47

  # Remove magnification
  defaults write com.apple.dock magnification -bool false

  # Show indicator for open apps
  defaults write com.apple.dock show-process-indicators -bool true

  # change screenshot file type to jpeg
  defaults write com.apple.screencapture type jpg
  
  # changes hidden apps icon transparency
  defaults write com.apple.Dock showhidden -bool true

  # Disable 'Are you sure you want to open this application?' dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Better Bluetooth audio
  read -p " - [*] Enable AptX codec [true/false]? " enableAptX

  defaults write bluetoothaudiod "Enable AptX codec" -bool $enableAptX
  defaults write bluetoothaudiod "Disable AAC codec" -bool $enableAptX

  if [[ $enableAptX = "false" ]]; then
    read -p " - [*] Enable AAC codec [true/false]? " enableAAC
    defaults write bluetoothaudiod "Enable AAC codec" -bool $enableAAC
  fi

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

    if [[ $filename = "toggle-headphones" ]]; then
      read -p " - [*] What's your headphones name (see Bluetooth menu)? " headphones

      echo $headphones > "$HOME/.headphones_name"
    fi

    osacompile -o "$filename.app" "$path/$filename.applescript"
  done
}

