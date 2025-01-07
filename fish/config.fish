if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ~/.config/fish/config.fish

starship init fish | source
set -Ux PATH $HOME/.cargo/bin $PATH
set -Ux PATH $HOME/.cargo/bin $PATH
set -Ux PATH $HOME/.cargo/bin $PATH

alias ls = eza
