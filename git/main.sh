git_install() {
	echo "[*] Intalling git..."
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

	cp ./git/.gitconfig $HOME/.gitconfig

	# a better git log
	git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
}
