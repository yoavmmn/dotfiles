#!/usr/bin/env bash

echo "[*] Update script"

echo "[*] Updating zsh..."
cp "./zsh/.zshrc" "$HOME/.zshrc"
cp -R "./zsh/zsh_local/" "$HOME/.zsh_local/"