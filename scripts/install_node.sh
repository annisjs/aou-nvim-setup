#!/usr/bin/env bash
NODE_VERSION="v22.19.0"

mkdir -p "$HOME/.local/node"
cd /tmp

curl -LO \
  "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz"

tar -xJf "node-${NODE_VERSION}-linux-x64.tar.xz" \
  -C "$HOME/.local/node" \
  --strip-components=1

echo 'export PATH="$HOME/.local/node/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
