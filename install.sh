#!/usr/bin/env bash

if [ "$(uname -s)" == "Linux" ]; then
	source "./lib/install_linux.sh"
elif [ "$(uname -s)" == "Darwin" ]; then
	source "./lib/install_darwin.sh"
else
	echo "Windows? why?"
fi

echo "[*] doing some magic for you..."

install

echo "[-] Don't forget to change to zsh"
echo "[-] Just run the following command:"
echo "   sudo chsh -s $(which zsh) $(whoami)"

echo
echo "Done."
