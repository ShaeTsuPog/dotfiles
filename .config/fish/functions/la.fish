function la --wraps=ls --wraps='eza -la --icons --time-style="+%d %b %I:%M %p"' --description 'alias la eza -la --icons --time-style="+%d %b %I:%M %p"'
    eza -la --icons --time-style="+%d %b %I:%M %p" $argv
end
