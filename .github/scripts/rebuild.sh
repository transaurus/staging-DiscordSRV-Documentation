#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for DiscordSRV/Documentation
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [ -f "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
    nvm install 24
    nvm use 24
fi

node --version
npm --version

# --- Package manager: Yarn ---
if ! command -v yarn &>/dev/null; then
    npm install -g yarn
fi

yarn --version

# --- Dependencies ---
yarn install --frozen-lockfile

# --- Build ---
DEBUG=search-local:* yarn build

echo "[DONE] Build complete."
