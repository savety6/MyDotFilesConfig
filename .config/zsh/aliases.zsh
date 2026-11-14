# eza replaces ls; --git on the long forms shows per-file git status
alias ls='eza --group-directories-first --icons --color=auto'
alias ll='eza -l --git --group-directories-first --icons --color=auto'
alias la='eza -la --git --group-directories-first --icons --color=auto'
alias l='eza -F --group-directories-first --icons --color=auto'
alias lt='eza -T --group-directories-first --icons --color=auto'

# ripgrep / fd / nvim take over their classic counterparts
alias grep='rg'
alias find='fd'
alias vim='nvim'
alias vi='nvim'

# bat (as batcat on Debian/Ubuntu) replaces cat
alias cat='batcat'
alias bat='batcat'
