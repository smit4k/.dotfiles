export PATH="$HOME/.local/bin:$PATH"


# bun completions
[ -s "/Users/smitpatil/.bun/_bun" ] && source "/Users/smitpatil/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# starship
eval "$(starship init zsh)"

# eza alias
alias ls="eza --icons"
