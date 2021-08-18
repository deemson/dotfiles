#!/usr/bin/env sh

# set -x

$HOME/.dotfiles/zsh/repos.py | while read -r url path; do
    git clone $url ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/$path
done
