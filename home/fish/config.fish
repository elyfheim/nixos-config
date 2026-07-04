bind ctrl-backspace backward-kill-word
set -g fish_greeting
set -g EDITOR nvim

alias nv="nvim"
alias ls="eza -lah --group-directories-first"
alias kb="kanban ~/boards.json"
alias zine="~/local-bin/zine"
starship init fish | source
