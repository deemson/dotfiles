#!/usr/bin/env sh

set -x

while read url path; do
    git clone $url ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/$path
done <<<$($HOME/.dotfiles/zsh/repos.py)
