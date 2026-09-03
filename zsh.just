[private]
default:
	@just --justfile {{source_file()}} --list

install-zap:
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

[private]
completions-dir:
	mkdir -p $HOME/.zsh/completions

bun:
	bun completions; fi

fzf:
	fzf --zsh > $HOME/.zsh/completions/fzf.zsh; fi

mise:
	if command -v mise >/dev/null 2>&1; then mise completions zsh > $HOME/.zsh/completions/mise.zsh; fi

task:
	task --completion zsh > $HOME/.zsh/completions/task.zsh; fi

just:
	just --completions zsh > $HOME/.zsh/completions/just.zsh; fi

completions: completions-dir bun fzf mise task just
