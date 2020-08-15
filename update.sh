#!/usr/bin/env bash

source "./macos/main.sh"
source "./finicky/main.sh"

echo "[*] Update script"

echo "[*] Updating zsh..."
cp "./zsh/.zshrc" "$HOME/.zshrc"
cp -R "./zsh/zsh_local/" "$HOME/.zsh_local/"

echo "[*] Updating tmux..."
cp -R "./tmux/tmux_local/" "$HOME/.tmux/"
cp "./tmux/.tmux.conf" "$HOME/.tmux.conf"

if [ "$(uname -s)" == "Darwin" ]; then
  echo "[*] Updating macOS configs and applescripts..."
  macos_magics
  finicky_magics
fi
