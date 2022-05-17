#!/usr/bin/env fish

# Set up
set SCRIPT_PATH (status --current-filename)
set REPO_PATH (dirname (realpath "$PWD/$SCRIPT_PATH"))
set SELF (basename $SCRIPT_PATH)

function info -a message
    set_color green
    echo "$SELF [INFO] $message"
    set_color normal
end

function error -a message
    set_color red
    echo "$SELF [EROR] $message"
    set_color normal
    exit 1
end

function warn -a message
    set_color yellow
    echo "$SELF [MIND] $message"
    set_color normal
end

if [ "$argv[1]" = "--initial" ]
    # Install dependencies.
    set platform (uname)
    switch $platform
        case Darwin
            info "Installing MacOS dependencies..."
            set deps (cat "$REPO_PATH/macos.deps")
            echo $deps | xargs brew install
        case Linux
            set distro (lsb_release -si)
            switch $distro
                case Ubuntu
                    info "Installing Ubuntu dependencies (may need sudo password)..."
                    set deps (cat "$REPO_PATH/ubuntu.deps")
                    echo $deps | xargs sudo apt install
                case '*'
                    error "Don't know how to install dependencies for: $platform-$distro"
            end
        case '*'
            error "Don't know how to install dependencies for: $platform"
    end
end

# Make sure oh-my-fish is installed.
if not functions -q omf
    info "Installing oh-my-fish..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    set REMINDERS $REMINDERS "You've just installed OMF for the first time; don't forget to install Powerline fonts from https://github.com/microsoft/cascadia-code/releases."
else
    info "oh-my-fish is already installed."
end

# Set default theme.
set omf_theme "agnoster"
set omf_theme_installed (omf list | grep $omf_theme)
if test -z $omf_theme_installed
    info "Installing oh-my-fish theme: $omf_theme..."
    set REMINDERS $REMINDERS "Set terminal color scheme to Solarized-Dark. (On iTerm2, check the \"Keep background colors opaque\" box.)"
    omf install $omf_theme
end
info "Setting oh-my-fish theme to $omf_theme..."
omf theme $omf_theme

# Create config.fish
set CONFIG_FISH_SOURCE "$REPO_PATH/config.fish"
set CONFIG_FISH_TARGET "$HOME/.config/fish/config.fish"
set CONFIG_FISH_LOCAL "$HOME/.config/fish/config.local.fish"

if not test -f "$CONFIG_FISH_LOCAL"
    info "Renaming config.fish to config.local.fish..."
    mv $CONFIG_FISH_TARGET $CONFIG_FISH_LOCAL
else
    info "config.local.fish already exists."
end

info "Updating config.fish to latest version..."
cp $CONFIG_FISH_SOURCE $CONFIG_FISH_TARGET

# Install Fish functions
info "Installing fish functions..."
mkdir -p "$HOME/.config/fish/functions/"
cp "$REPO_PATH/fish_functions/"* "$HOME/.config/fish/functions/"

# Install RC files
info "Installing .vimrc..."
cp "$REPO_PATH/vimrc" ~/.vimrc

# Configure Git
info "Configuring Git..."
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global merge.conflictstyle diff3
git config --global pull.ff only
git config --global user.name "Mark E. Haase"

# Some machines (e.g. work) might have different email.
git config --global user.email >/dev/null; or set REMINDERS $REMINDERS "Set your git email: git config --global user.email mehaase@gmail.com"

info "🌟🚀 Done 🚀🌟"

if set -q REMINDERS
    warn ""
    warn "************ REMINDERS ************"
    for reminder in $REMINDERS
        warn "---> $reminder"
    end
    warn "***********************************"
end
