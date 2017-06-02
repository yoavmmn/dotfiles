sublime_install() {
  echo "Installing Sublime Text 3..."
  DISTRO=$(get_distro)

  if [ $DISTRO == "RedHat" ]; then
    rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg &> /dev/null
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    dnf install -y sublime-text
  elif [ $DISTRO == "Debian" ]; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    apt-get install -y sublime-text &> /dev/null
  fi

  echo "[*] Installed Sublime Text 3. moving on..."
}

sublime_magics() {
  if [ $(cmd_exist "subl") -eq 0 ]; then
    echo "[*] Sublime Text 3 is already installed"
  else
    sublime_install
  fi

  echo "[*] Setting up sublime config files..."
  if [ "$(uname -s)" == "Linux" ]; then
    cp "./sublime/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
    cp "./sublime/Package Control.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"
  elif [ "$(uname -s)" == "Darwin" ]; then
    cp "./sublime/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    cp "./sublime/Package Control.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
  fi
}