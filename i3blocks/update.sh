#!/usr/bin/env sh

set -x
cp $HOME/.config/i3blocks/config ./
cp $HOME/.config/i3blocks/colors.sh ./
cp $HOME/.config/i3blocks/common.sh ./
cp -r $HOME/.config/i3blocks/blocks ./
cp $HOME/.config/systemd/user/*.service ./systemd/user-units/