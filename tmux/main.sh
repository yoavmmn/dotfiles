install_zsh() {
  if [ $1 == "RedHat" ]; then
    dnf install -y tmux &> /dev/null &
  elif [ $1 == "Debian" ]; then
    apt-get install -y tmux &> /dev/null &
  fi

  echo "[*] Installing tmux..."

  [ $? -eq 0 ] \
    && echo "[*] Installed tmux. moving on..." \
    || echo "[*] Couldn't install tmux."
}

tmux_magics() {
  DISTRO=$(get_distro)

  if [[ $DISTRO != "macOS" ]]; then
    install_tmux $DISTRO
  fi

  echo "[*] Setting up tmux config."

  git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

  cp "./tmux/.tmux.conf" "$HOME/.tmux.conf"
  cp -R "./tmux/tmux_local/" "$HOME/.tmux/"

  # give permissions so right_segments.sh could be executed
  for file in ~/.tmux/*.sh; do
    if [[ -f $file ]]; then
      chmod +x $file
    fi
  done
}
