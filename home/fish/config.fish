bind ctrl-backspace backward-kill-word
set -g fish_greeting
set -g EDITOR nvim

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

alias nv="nvim"
alias ls="eza -lah --group-directories-first"
alias kb="kanban ~/boards.json"
alias zine="~/local-bin/zine"
starship init fish | source
