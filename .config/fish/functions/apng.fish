function apng
    argparse 'a/all' -- $argv
    or return

    if set -q _flag_all
        for file in *.gif
            set -l output (string replace -r '\.gif$' '.png' "$file")
            ffmpeg -i "$file" -vf "scale='if(gt(iw,ih),220,-1)':'if(gt(iw,ih),-1,220)':flags=lanczos" \
            -f apng -plays 0 -pred avg -pix_fmt rgba "$output"
        end
    else if set -q argv[1]
        set -l input $argv[1]
        set -l output (string replace -r '\.gif$' '.png' "$input")
        ffmpeg -i "$input" -vf "scale='if(gt(iw,ih),220,-1)':'if(gt(iw,ih),-1,220)':flags=lanczos" \
        -f apng -plays 0 -pred avg -pix_fmt rgba "$output"
    else
        echo "Usage: gif2apng [file.gif] or gif2apng -a"
    end
end

