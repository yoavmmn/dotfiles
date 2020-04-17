brew_pkgs_list=""
cask_pkgs_list=""

install_brew_pkg() {
  brew install $1 &> /dev/null &
  echo "   [*] Installing $1..."

  [ $? -eq 0 ] \
    && echo "   [*] Installed $1." \
    || echo "   [!] Cloudn't install $1."
}

install_cask_pkg() {
  brew install cask $1 &> /dev/null &
  echo "   [*] Installing $1..."

  [ $? -eq 0 ] \
    && echo "   [*] Installed $1." \
    || echo "   [!] Cloudn't install $1."
}

install_brew_pkgs() {
  brew_pkgs_list=$(cat ./brew/brew.txt)

  for pkg in ${brew_pkgs_list[@]}; do
    install_brew_pkg $pkg
  done
}

install_cask_pkgs() {
  cask_pkgs_list=$(cat ./brew/cask.txt)

  for pkg in ${cask_pkgs_list[@]}; do
    install_cask_pkg $pkg

    if [[ $pkg = "horndis" ]]; then
      echo "   [*] Loading HoRNDIS kext"
      kextload /Library/Extensions/HoRNDIS.kext
    fi
  done
}

install_brew() {
  # insatlling homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # adding cask
  brew tap caskroom/cask
}

brew_magics() {
  if [ $(cmd_exist "brew") -eq 0 ]; then
    echo "[!] Homebrew already installed."
  else
    echo "[*] Installing homebrew..."
    install_brew
  fi

  echo "[*] Installing homebrew packages"
  install_brew_pkgs
  install_cask_pkgs
}