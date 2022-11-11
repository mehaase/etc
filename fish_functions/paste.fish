function paste
    # Multi-platform wrapper to get clipboard contents.
    switch (uname)
        case Linux
            xclip -o -selection clipboard
        case Darwin
            pbpaste
        case '*'
            echo "PASTE.FISH NOT SUPPORTED"
            return 1
    end
end
