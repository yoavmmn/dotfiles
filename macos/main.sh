macos_magics() {
  echo "[*] Setting up macOS configs..."

  defaults write com.apple.dock autohide -bool true # Automatically hide and show the Dock
  defaults write com.apple.dock tilesize -integer 47 # Set the tile size to 47
  defaults write com.apple.screencapture type jpg # change screenshot file type to jpeg
  defaults write com.apple.Dock showhidden -bool true # changes hidden apps icon transparency

  # compile applescripts
  path="./macos/applescripts"
  scripts=$(ls $path)

  for script in ${scripts[@]}; do
    filename="${script%.*}"
    echo $filename
    osacompile -o "$filename.app" "$path/$filename.applescript"
  done
}