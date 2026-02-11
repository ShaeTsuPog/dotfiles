function ls --wraps='eza --icons --time-style="+%d %b %I:%M %p"' --description 'alias ls eza --icons --time-style="+%d %b %I:%M %p"'
    eza --icons --time-style="+%d %b %I:%M %p" $argv
end
