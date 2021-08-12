#!/usr/bin/env sh

set -x
cp zshrc $HOME/.zshrc
./clone-plugin-repos.sh || true
touch $HOME/.zshenvrc