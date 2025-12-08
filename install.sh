#!/bin/bash

# =======================================================
# NVIM Local Installer v1.0
# =======================================================

# --- Configuration Section ---
# Destination directory for the final Neovim config
NVIM_CONFIG_DIR="$HOME/.config/nvim"
# -----------------------------

echo "Initiating local installation routine."
echo "-----------------------------------"

echo "Creating destination directory: $NVIM_CONFIG_DIR"
mkdir -p "$NVIM_CONFIG_DIR"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create destination directory. Halting."
    exit 1
fi

# 1. Move/Copy and make the update script executable
if [ -f "update.sh" ]; then
    echo "Moving update.sh script into $NVIM_CONFIG_DIR"
    cp update.sh "$NVIM_CONFIG_DIR/"
    chmod +x "$NVIM_CONFIG_DIR/update.sh"
    echo "Status: update.sh copied and executable."
else
    echo "Warning: update.sh script not found in the current directory. Skipping update script install."
fi

# 2. Move/Copy the nvim folder contents
if [ -d "nvim" ]; then
    echo "Merging contents of nvim/ folder into $NVIM_CONFIG_DIR"
    # Using rsync to copy contents safely and recursively, merging directories.
    rsync -av nvim/ "$NVIM_CONFIG_DIR"

    if [ $? -eq 0 ]; then
        echo "-----------------------------------"
        echo "Installation successful."
        echo "Configuration and update script are now installed."
        echo "You can update your configuration anytime by running:"
        echo "$NVIM_CONFIG_DIR/update.sh"
        echo "-----------------------------------"
    else
        echo "Error: File transfer failure (rsync). Halting."
        exit 1
    fi
else
    echo "Error: Source 'nvim' directory not found. Halting."
    exit 1
fi
