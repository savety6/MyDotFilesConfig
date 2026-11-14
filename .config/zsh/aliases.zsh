# eza replaces ls
alias ls='eza --group-directories-first --icons --color=auto'
alias ll='eza -l --group-directories-first --icons --color=auto'
alias la='eza -la --group-directories-first --icons --color=auto'
alias l='eza -F --group-directories-first --icons --color=auto'
alias lt='eza -T --group-directories-first --icons --color=auto'

# ripgrep / fd / nvim take over their classic counterparts
alias grep='rg'
alias find='fd'
alias vim='nvim'
alias vi='nvim'
