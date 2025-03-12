if status --is-interactive; and command -sq fnm
    fnm completions --shell fish | source
    fnm env --use-on-cd | source
end
