source "./lib/utils.sh"
source "./git/main.sh"
source "./sublime/main.sh"
source "./npm/main.sh"

install() {
  echo "[*] Installig for macOS..."

  get_sudo
  [ $? -eq 0 ] \
    && echo "[*] Granted sudo access" \
    || not_sudo

  git_magics
  sublime_magics
  npm_magics
}
