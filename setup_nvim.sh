#!/usr/bin/env bash

SCRIPT_DIR="scripts"

echo "Installing Neovim"
bash $SCRIPT_DIR/get_install_nvim.sh

echo "Installing node" 
bash $SCRIPT_DIR/install_node.sh

echo "Installing quarto"
bash $SCRIPT_DIR/install_quarto.sh

echo "Installing tree sitter"
bash $SCRIPT_DIR/install_tree_sitter.sh

echo "Making ~/.config/nvim directory"
mkdir -p ~/.config/nvim

echo "Copying init.lua into nvim directory"
cp init/init.lua ~/.config/nvim/

echo "Setup complete. Restart your terminal."
