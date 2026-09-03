#!/usr/bin/env bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
mkdir -p "$HOME/.local/opt/nvim"
mkdir -p "$HOME/.local/bin"

rm -rf "$HOME/.local/opt/nvim"
mkdir -p "$HOME/.local/opt/nvim"

tar -C "$HOME/.local/opt/nvim" \
  --strip-components=1 \
  -xzf nvim-linux-x86_64.tar.gz

ln -sfn "$HOME/.local/opt/nvim/bin/nvim" "$HOME/.local/bin/nvim"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
mkdir -p ~/.local/share/nvim/lazy

git clone --filter=blob:none \
  --branch=stable \
  https://github.com/folke/lazy.nvim.git \
  ~/.local/share/nvim/lazy/lazy.nvim
