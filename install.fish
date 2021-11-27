#!/usr/bin/env fish

# Set up
set SCRIPT_PATH (status --current-filename)
set REPO_PATH (dirname (realpath "$PWD/$SCRIPT_PATH"))

# Make sure oh-my-fish is installed.
set omf (which omf)
if test -z $omf
    echo "Installing oh-my-fish..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    set new_omf true
else
    echo "Existing oh-my-fish found at $omf"
end

# Set default theme.
set omf_theme "bobthefish"
echo "Setting oh-my-fish theme to $omf_theme..."
omf install $omf_theme
omf theme $omf_theme
set theme_color_scheme solarized-dark

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

# Remind to install powerline font.
set font_url "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete%20Mono.otf"
set font_file "Inconsolata_Nerd_Font_Complete_Mono.otf"
if test -n $new_omf
    curl $font_url -o $font_file
    echo "Since you've just installed OMF for the first time,"
    echo "don't forget to install Powerline fonts. I just downloaded"
    echo "it to '$font_file'."
end
