typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
# known command but not in any known category (e.g. not builtin or installed binary)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue,underline'

ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'

ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'

ZSH_HIGHLIGHT_STYLES[comment]='fg=8' # grey
