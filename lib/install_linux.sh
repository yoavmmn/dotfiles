source "./lib/utils.sh"
source "./git/main.sh"

install() {
	echo "[*] Installing for linux..."
	echo "[?] I need sudo permissions now."

	get_sudo
	[ $? -eq 0 ] \
		&& echo "[*] Granted sudo access" \
		|| not_sudo

	git_magics
}
