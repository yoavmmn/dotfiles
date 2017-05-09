#!/usr/bin/env bash

if [ "$(uname -s)" == "Linux" ]; then
	source "./lib/install_linux.sh"
elif [ "$(uname -s)" == "Darwin" ]; then
	source "./lib/install_darwin.sh"
else
	echo "Windows? why?"
fi

install

echo
echo "Done."
