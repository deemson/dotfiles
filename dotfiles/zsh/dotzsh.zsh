export LANG='en_US.UTF-8'
export EDITOR=nvim

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"

# completion
autoload -Uz compinit
compinit
# treat words correctly when using Alt+D or Alt+Backspace (respect $WORDCHARS)
autoload -U select-word-style
select-word-style bash

# plugins
source $HOME/.zsh/plugins/syntax-highlight.zsh
source $HOME/.zsh/plugins/history-substring-search.zsh
# external
source $HOME/.zsh/external/pyenv.zsh
source $HOME/.zsh/external/bun.zsh

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

eval "$(starship init zsh)"

