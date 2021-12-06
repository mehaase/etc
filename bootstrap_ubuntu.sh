#!/bin/sh
#
# Install fish and Terminator for Ubuntu.

echo "Installing fish and Terminator (may need sudo password)..."
sudo apt install fish terminator

echo "Setting fish as login shell (may need user password)..."
chsh -s /usr/bin/fish

echo "Ubuntu bootstrap complete."
