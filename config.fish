# Set up useful abbreviations.
abbr --add --global ff "git merge --ff-only origin/(git branch --show-current)"
abbr --add --global pushup "git push -u origin (git branch --show-current)"

# Source the local fish config:
source "$HOME/.config/fish/config.local.fish"
