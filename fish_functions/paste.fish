function paste
    # Multi-platform wrapper to get clipboard contents.
    switch (uname)
        case Linux
            # NOT TESTED YET:
            xclip -o -sel clip
        case Darwin
            pbpaste
        case '*'
            echo "PASTE.FISH NOT SUPPORTED"
            return 1
    end
end
