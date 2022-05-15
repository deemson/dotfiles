#!/usr/bin/env sh

touch $HOME/.config/fish/env.fish
echo 'status is-login; and pyenv init --path | source' >> $HOME/.config/fish/env.fish
echo 'status is-interactive; and pyenv init - | source' >> $HOME/.config/fish/env.fish