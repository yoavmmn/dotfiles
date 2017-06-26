source "./lib/utils.sh"
source "./git/main.sh"
source "./sublime/main.sh"
source "./npm/main.sh"

install() {
  echo "[*] Installing for linux..."

  get_sudo
  [ $? -eq 0 ] \
    && echo "[*] Granted sudo access" \
    || not_sudo

  git_magics

  sublime_magics

  npm_magics
}
