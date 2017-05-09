git_install() {
	echo "Intalling git..."
	DISTRO=$(get_distro)

	if [ $DISTRO == "RedHat" ]; then
		dnf install -y git &> /dev/null
	elif [ $DISTRO == "Debian" ]; then
		apt-get install -y git &> /dev/null
	fi

	echo "[*] Installed git. moving on..."
}

git_magics() {
	if [ $(cmd_exist "git") -eq 0 ]; then
		echo "[*] git is already installed"
	else
		git_install
	fi

	echo "[*] doing some magic for you..."

	cp ./git/.gitconfig $HOME/.gitconfig
}
