#!/usr/bin/env fish

# Set up
set SCRIPT_PATH (status --current-filename)
set REPO_PATH (dirname (realpath "$PWD/$SCRIPT_PATH"))

# Make sure oh-my-fish is installed.
set omf (which omf)
if test -z $omf
    echo "Installing oh-my-fish..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
else
    echo "Existing oh-my-fish found at $omf"
end

# Set default theme.
set omf_theme "agnoster"
echo "Setting oh-my-fish theme to $omf_theme..."
omf install $omf_theme
omf theme $omf_theme

# Create config.fish
set CONFIG_FISH_SOURCE "$REPO_PATH/config.fish"
set CONFIG_FISH_TARGET "$HOME/.config/fish/config.fish"
set CONFIG_FISH_LOCAL "$HOME/.config/fish/config.local.fish"

if not test -f "$CONFIG_FISH_LOCAL"
    echo "Renaming config.fish to config.local.fish..."
    mv $CONFIG_FISH_TARGET $CONFIG_FISH_LOCAL
else
    echo "config.local.fish already exists."
end

echo "Updating config.fish to latest version..."
cp $CONFIG_FISH_SOURCE $CONFIG_FISH_TARGET

# Install Fish functions
echo "Installing fish functions..."
mkdir -p "$HOME/.config/fish/functions/"
cp "$REPO_PATH/fish_functions/"* "$HOME/.config/fish/functions/"

# Install RC files
echo "Installing .vimrc..."
cp "$REPO_PATH/vimrc" ~/.vimrc
