install_zsh() {
  if [ $1 == "RedHat" ]; then
    dnf install -y git &> /dev/null &
  elif [ $1 == "Debian" ]; then
    apt-get install -y git &> /dev/null &
  fi

  echo "[*] Installing zsh..."

  [ $? -eq 0 ] \
    && echo "[*] Installed zsh. moving on..." \
    || echo "[*] Couldn't install zsh."
}

zsh_magics() {
  DISTRO=$(get_distro)

  if [ $DISTRO == "RedHat" ]; then
    install_zsh $DISTRO
  elif [ $DISTRO == "Debian" ]; then
    install_zsh $DISTRO
  fi

  curl -L git.io/antigen > "$HOME/antigen.zsh" &> /dev/null &

  echo "[*] Installing antigen..."

  [ $? -eq 0 ] \
    && echo "[*] Installed antigen. moving on..." \
    || echo "[!] Couldn't install antigen."

  if [ -d "$HOME/.config/base16-shell" ]; then
    echo "[!] base16-shell is already installed."
  else
    git clone "https://github.com/chriskempson/base16-shell.git" "$HOME/.config/base16-shell" &> /dev/null &

    echo "[*] Installing base16-shell..."

    [ $? -eq 0 ] \
      && echo "[*] Installed base16-shell. moving on..." \
      || echo "[!] Couldn't install base16-shell."
  fi
}