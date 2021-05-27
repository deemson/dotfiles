#!/usr/bin/env sh

set -x
mkdir -p $HOME/.config/systemd/user
cp user-units/* $HOME/.config/systemd/user/