#!/usr/bin/env bash

# Set path of script
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo $PLUGIN_DIR

tmux source "${PLUGIN_DIR}/evergarden.conf"
