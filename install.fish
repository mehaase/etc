#!/usr/bin/env fish

# Set up
set SCRIPT_PATH (status --current-filename)
set REPO_PATH (dirname (realpath "$PWD/$SCRIPT_PATH"))

# Check dependencies.
set DEPENDENCIES git
for dep in $DEPENDENCIES
    if ! which $dep >/dev/null
        echo "ERROR: git must be installed"; and exit 1
    end
end

# Make sure oh-my-fish is installed.
if not functions -q omf
    echo "Installing oh-my-fish..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish 2>&1 >/dev/null
    set REMINDERS $REMINDERS "You've just installed OMF for the first time; don't forget to install Powerline fonts from https://github.com/microsoft/cascadia-code/releases."
else
    echo "oh-my-fish is already installed."
end

# Set default theme.
set omf_theme "bobthefish"
set omf_theme_installed (omf list | grep $omf_theme)
if test -z $omf_theme_installed
    echo "Installing oh-my-fish theme: $omf_theme..."
    omf install $omf_theme
end
echo "Setting oh-my-fish theme to $omf_theme..."
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

# Configure Git
echo "Configuring Git..."
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global merge.conflictstyle diff3
git config --global pull.ff only
git config --global user.name "Mark E. Haase"

# Some machines (e.g. work) might have different email.
git config --global user.email >/dev/null; or set REMINDERS $REMINDERS "Set your git email: git config --global user.email mehaase@gmail.com"

echo "Done."

if set -q REMINDERS
    echo ""
    echo "************ REMINDERS ************"
    for reminder in $REMINDERS
        echo "---> $reminder"
    end
    echo "***********************************"
end
