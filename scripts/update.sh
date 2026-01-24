#!/bin/bash

REPO_URL="https://github.com/TallenPeli/tallenpeli.nvim"
CLONE_DIR="$HOME/.local/share/nvim/tallenpeli/"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# check if clone directory exists
if [ ! -d "$CLONE_DIR/.git" ]; then
    echo "First time setup. Cloning repository..."
    git clone "$REPO_URL" "$CLONE_DIR"
else
    cd "$CLONE_DIR" || exit
    git fetch status &> /dev/null

    LOCAL=$(git rev-parse HEAD)
    REMOTE=$(git rev-parse @{u})

    if [ "$LOCAL" = "$REMOTE" ]; then
        echo "Up to date."
        exit 1
    fi

    echo "Remote changes detected. Updating..."
    git pull
fi

echo "Merging changes..."
mkdir -p "$NVIM_CONFIG_DIR"
rsync -av --delete-after "$CLONE_DIR/nvim/" "$NVIM_CONFIG_DIR"
cp "$CLONE_DIR/scripts/update.sh" "$NVIM_CONFIG_DIR/update.sh"

echo "Update successful!"
exit 0
