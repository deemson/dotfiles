#!/usr/bin/env sh

set -x
cp zshrc $HOME/.zshrc
cp p10k.zsh $HOME/.p10k.zsh
./clone-plugin-repos.sh || true
touch $HOME/.zshenvrc