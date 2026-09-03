#!/usr/bin/env bash
mkdir -p "$HOME/.local/bin"


curl -L \
  https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.10/tree-sitter-linux-x64.gz \
  -o /tmp/tree-sitter.gz

gzip -dc /tmp/tree-sitter.gz > "$HOME/.local/bin/tree-sitter"
chmod +x "$HOME/.local/bin/tree-sitter"

