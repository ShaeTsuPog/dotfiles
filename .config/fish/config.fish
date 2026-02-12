if status is-interactive
    starship init fish | source
		fzf --fish | source
		zoxide init fish --cmd cd | source

		set -gx FZF_DEFAULT_OPTS_FILE "$HOME/.config/fzf/vague.conf"
		set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --exclude .git -x eza --icons=always --color=always {}"
		set -gx FZF_DEFAULT_OPTS "--ansi"
    set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
    set -gx EZA_COLORS "uu=35:da=33"

    function starship_transient_prompt_func
        starship module character
    end

    enable_transience

    set -g fish_greeting ""
    set -gx COLORTERM truecolor

    # Prompt Bottom-Pinning
    function fly_to_bottom --on-event fish_prompt
        tput cup $LINES 0
    end
end

