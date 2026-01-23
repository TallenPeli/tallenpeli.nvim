#!/bin/bash

# =======================================================
# NVIM Configuration Manager v1.0
# =======================================================

# --- Configuration Section ---
# Source repository
REPO_URL="https://github.com/TallenPeli/tallenpeli.nvim"

# Clone location (Holding area for the remote source)
CLONE_DIR="$HOME/tallenpeli_repo"

# Destination location (Active user configuration)
NVIM_CONFIG_DIR="$HOME/.config/nvim"
# -----------------------------

echo "Initiating system routine: Neovim configuration sync"
echo "-------------------------------------------------"

# ----------------------------------------------------------------------
# STEP 1 & 2: Repository Acquisition (Clone or Update)
# ----------------------------------------------------------------------

echo "Checking clone directory status: $CLONE_DIR"

if [ -d "$CLONE_DIR/.git" ]; then
    echo "Status: Repository detected."
    echo "Processing: Executing git pull for update."
    git -C "$CLONE_DIR" pull
    
    if [ $? -ne 0 ]; then
        echo "Error: Update failure. Halting operation."
        exit 1
    fi
else
    echo "Status: Directory not found."
    echo "Processing: Cloning new repository from $REPO_URL."
    git clone "$REPO_URL" "$CLONE_DIR"
    
    if [ $? -ne 0 ]; then
        echo "Error: Clone failure. Halting operation."
        exit 1
    fi
fi


# ----------------------------------------------------------------------
# STEP 3: File Transfer and Merge
# ----------------------------------------------------------------------

# Ensure target directory exists
mkdir -p "$NVIM_CONFIG_DIR"

# Verify source 'nvim' directory is present inside the clone
if [ ! -d "$CLONE_DIR/nvim" ]; then
    echo "Error: Source 'nvim' subdirectory missing in cloned repo. Halting operation."
    exit 1
fi

if [ -f "$CLONE_DIR/update.sh" ]; then
    echo "Processing: Copying new update.sh script."
    cp "$CLONE_DIR/update.sh" "$NVIM_CONFIG_DIR/"
fi

echo "Processing: Merging contents from $CLONE_DIR/nvim/ to $NVIM_CONFIG_DIR"
# rsync is used for robust recursive file synchronization.
# --delete-after ensures configuration files removed in the source are also removed in the target.
rsync -av --delete-after "$CLONE_DIR/nvim/" "$NVIM_CONFIG_DIR"

if [ $? -eq 0 ]; then
    echo "-------------------------------------------------"
    echo "Operation successful."
    echo "Configuration sync complete."
    echo "-------------------------------------------------"
else
    echo "-------------------------------------------------"
    echo "Error: File transfer failure (rsync). Halting operation."
    echo "-------------------------------------------------"
    exit 1
fi
