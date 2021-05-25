install_zsh() {
  if [ $1 == "RedHat" ]; then
    dnf install -y zsh &> /dev/null &
  elif [ $1 == "Debian" ]; then
    apt-get install -y zsh &> /dev/null &
  fi

  echo "[*] Installing zsh..."

  [ $? -eq 0 ] \
    && echo "[*] Installed zsh. moving on..." \
    || echo "[*] Couldn't install zsh."
}

antigen() {
  git clone "https://github.com/zsh-users/antigen.git" "$HOME/.antigen" &> /dev/null &

  echo "[*] Installing antigen..."

  [ $? -eq 0 ] \
    && echo "[*] Installed antigen. moving on..." \
    || echo "[!] Couldn't install antigen."
}

base16() {
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

autocomplete() {
  if [ -d "$HOME/.zsh/zsh-autocomplete" ]; then
    echo "[!] zsh-autocomplete is already installed."
  else
    git clone --depth 1 -- "https://github.com/marlonrichert/zsh-autocomplete.git" "$HOME/.zsh/zsh-autocomplete" &> /dev/null &

    echo "[*] Installing zsh-autocomplete..."

    [ $? -eq 0 ] \
      && echo "[*] Installed zsh-autocomplete. moving on..." \
      || echo "[!] Couldn't install zsh-autocomplete."
  fi
}

setup_zsh() {
  echo "[*] Setting up zsh config and theme."

  mkdir "$HOME/.zsh"

  cp "./zsh/.zshrc" "$HOME/.zshrc"
  cp -R "./zsh/zsh_local/" "$HOME/.zsh_local/"
}

zsh_magics() {
  DISTRO=$(get_distro)

  install_zsh $DISTRO

  antigen
  base16
  autocomplete

  setup_zsh
}