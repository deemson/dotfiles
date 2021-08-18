#!/usr/bin/env python

repos = (
    ('https://github.com/romkatv/powerlevel10k.git', 'themes/powerlevel10k'),
    ('https://github.com/zsh-users/zsh-syntax-highlighting.git', 'plugins/zsh-syntax-highlighting'),
    ('https://github.com/zsh-users/zsh-autosuggestions', 'plugins/zsh-autosuggestions'),
    ('https://github.com/zsh-users/zsh-history-substring-search', 'plugins/zsh-history-substring-search')
)

for repo in repos:
    print(repo[0] + ' ' + repo[1])