#!/usr/bin/env bash
set -euo pipefail

VERSION="1.10.18"
INSTALL_DIR="$HOME/apps"

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "Downloading Quarto ${VERSION}..."

wget -O "quarto-${VERSION}-linux-amd64.tar.gz" \
  "https://github.com/quarto-dev/quarto-cli/releases/download/v${VERSION}/quarto-${VERSION}-linux-amd64.tar.gz"

echo "Extracting..."
tar -xzf "quarto-${VERSION}-linux-amd64.tar.gz"

QUARTO_DIR="$INSTALL_DIR/quarto-${VERSION}"

if [ ! -x "$QUARTO_DIR/bin/quarto" ]; then
  echo "ERROR: quarto executable not found in $QUARTO_DIR/bin"
  exit 1
fi

SHELL_RC="$HOME/.bashrc"

if [ -n "${ZSH_VERSION:-}" ] || [ "$(basename "${SHELL:-}")" = "zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
fi

PATH_LINE="export PATH=\"$QUARTO_DIR/bin:\$PATH\""

grep -qxF "$PATH_LINE" "$SHELL_RC" 2>/dev/null || \
  echo "$PATH_LINE" >> "$SHELL_RC"

export PATH="$QUARTO_DIR/bin:$PATH"

echo
echo "Quarto installed:"
quarto --version

echo
echo "Run the following to reload your shell:"
echo "source $SHELL_RC"
