module_list=""

install_module() {
  echo "[*] Installing $1..."
  npm install -g $1 &> /dev/null & 

  [ $? -eq 0 ] \
    && echo "[*] Installed $1." \
    || echo "[!] Couldn't install $1."
}

npm_install() {
  modules=$(cat ./npm/modules.txt)

  if [[ $module_list == "" ]]; then
    module_list=$(npm list -g --depth=0 -s)
  fi

  for module in ${modules[@]}; do
    [[ $(echo $module_list | grep "$module@") ]] \
      && echo "[*] $module is already installed. moving on..." \
      || install_module $module
  done
}

npm_magics() {
  echo "[*] Installing npm modules..."
  npm_install
}