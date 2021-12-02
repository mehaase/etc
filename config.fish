# Set up useful abbreviations.
abbr --add --global drun "docker run --rm -it (paste)"
abbr --add --global dexec "docker exec -it (paste) bash"
abbr --add --global ff "git merge --ff-only origin/(git branch --show-current)"
abbr --add --global pushup "git push -u origin (git branch --show-current)"
abbr --add --global l "ls -lah"

# Set `less` options.
set -gx LESS NR

# Set fish theme.
set theme_color_scheme solarized-dark

# Source the local fish config:
source "$HOME/.config/fish/config.local.fish"
