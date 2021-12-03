#!/bin/sh
#
# Install Homebrew, fish, and iTerm2 for MacOS.

if command -v brew &> /dev/null; then
    echo "Homebrew is already installed."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if command -v fish &> /dev/null; then
    echo "Fish is already installed."
else
    echo "Installing Fish..."
    brew install fish || exit 1

    echo "Setting fish as login shell..."
    chsh -s fish
fi

if test -d /Applications/iTerm.app/; then
    echo "iTerm2 is already installed."
else
    echo "Installing iTerm 2"
    brew install --cask iterm2
fi

echo "MacOS bootstrap complete."
