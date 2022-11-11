function copy
    # Multi-platform wrapper to set clipboard contents.
    switch (uname)
        case Linux
            xclip -i -selection clipboard
        case Darwin
            # NOT TESTED YET:
            pbcopy
        case '*'
            echo "COPY.FISH NOT SUPPORTED"
            return 1
    end
end
