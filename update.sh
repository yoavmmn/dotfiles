#!/usr/bin/env bash

echo "[*] Update script"

echo "[*] Updating zsh..."
cp "./zsh/.zshrc" "$HOME/.zshrc"
cp "./zsh/.zshtheme" "$HOME/.zshtheme"