# Etc

## Purpose

Set up my machines with helpful configurations and shortcuts.

## Process

1. Run a bootstrap script (written in POSIX sh), e.g. `bootstrap_macos.sh`
2. Open a new fish shell (which should now be your default shell)
3. Run `fish install.fish`

## Notes

* Nice Fish reference: https://github.com/jorgebucaran/cookbook.fish
* fswatch example: `fswatch -o test.dot | xargs -n1 -I{} dot -Tpng -O test.dot`
