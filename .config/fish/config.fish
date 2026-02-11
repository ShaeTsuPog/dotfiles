if status is-interactive
    starship init fish | source
		zoxide init fish --cmd cd | source

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

