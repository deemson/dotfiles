bun-zsh:
	bun completions

fzf-zsh:
	fzf --zsh > $HOME/.zsh/apps/fzf.zsh

mise-zsh:
	mise completions zsh > $HOME/.zsh/apps/mise.zsh

task-zsh:
	task --completion zsh > $HOME/.zsh/apps/task.zsh

just-zsh:
	just --completions zsh > $HOME/.zsh/apps/just.zsh
