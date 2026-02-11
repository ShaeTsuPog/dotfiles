function extract
    set -l targets $argv

    # Logic for extracting all files in the directory
    if contains -- --all $argv
        set targets *
        # Fallback to newest file if no argument is provided
    else if test -z "$argv"
        set targets (ls -t | head -n1)
        echo "No file specified. Attempting to extract newest file: $targets"
    end

    for file in $targets
        # Skip the --all flag itself if it's in the list
        if test "$file" = --all
            continue
        end

        switch $file
            case '*.tar.bz2' '*.tbz2'
                tar xjf $file
            case '*.tar.gz' '*.tgz'
                tar xzf $file
            case '*.bz2'
                bunzip2 $file
            case '*.rar'
                unrar x $file
            case '*.gz'
                gunzip $file
            case '*.tar'
                tar xf $file
            case '*.zip'
                unzip $file
            case '*.Z'
                uncompress $file
            case '*.7z'
                7z x $file
            case '*.xz'
                xz -d $file
            case '*'
                # Only echo error if we aren't in --all mode to avoid spamming 
                # for non-archive files like .txt or .png
                if not contains -- --all $argv
                    echo "'$file' cannot be extracted"
                end
        end
    end
end
