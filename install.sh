#!/bin/bash

# Installation script for Pomodoro Timer

echo "Installing Pomodoro Timer..."

# Check if running as root for system-wide install
if [ "$EUID" -eq 0 ]; then 
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

# Copy and rename script
cp pomodoro.sh "$INSTALL_DIR/pomodoro"
chmod +x "$INSTALL_DIR/pomodoro"

# Add to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> ~/.bashrc
    echo "Added $INSTALL_DIR to PATH in ~/.bashrc"
fi

echo ""
echo "✓ Pomodoro installed successfully!"
echo ""
echo "Usage:"
echo "  pomodoro           # Default: 25 min work, 5 min break"
echo "  pomodoro 30 10     # Custom: 30 min work, 10 min break"
echo ""

if [ "$EUID" -ne 0 ]; then
    echo "Note: Run 'source ~/.bashrc' or restart terminal to use 'pomodoro' command"
fi
