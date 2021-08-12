#!/usr/bin/env sh

set -x
mkdir -p $HOME/.config/fish/functions
cp -r functions/* $HOME/.config/fish/functions/
cp config.fish $HOME/.config/fish/config.fish