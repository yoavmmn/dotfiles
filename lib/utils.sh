# some of the functions has been taken from https://github.com/yardnsm/dotfiles

not_sudo() {
	echo "[!] I need sudo access to continue."
	exit 1
}

# credit to yardnsm
get_sudo() {
  echo "[?] I need sudo permissions now."
	sudo -v &> /dev/null
}

# credit to yardnsm
cmd_exist() {
	command -v "$1" &> /dev/null
	echo $?
}

get_distro() {
# Detects which OS and if it is Linux then it will detect which Linux Distribution.
	OS=`uname -s`

	if [ "${OS}" = "SunOS" ]; then
		DIST='Solaris'
	elif [ "${OS}" = "AIX" ]; then
		DIST= 'AIX'
	elif [ "${OS}" = "Linux" ]; then
        	KERNEL=`uname -r`
        	if [ -f /etc/redhat-release ]; then
                	DIST='RedHat'
        	elif [ -f /etc/SuSE-release ]; then
			DIST='OpenSUSE'
        	elif [ -f /etc/mandrake-release ]; then
                	DIST='Mandrake'
        	elif [ -f /etc/debian_version ]; then
                	DIST="Debian"
        	fi

        	if [ -f /etc/UnitedLinux-release ]; then
                	DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
        	fi
	elif [ "${OS}" = "Darwin" ]; then
		DIST='macOS'
	fi

	echo ${DIST}
}
