#!/usr/bin/env sh

set -x
mkdir -p $HOME/.config/i3blocks/blocks
cp config $HOME/.config/i3blocks/config
cp colors.sh $HOME/.config/i3blocks/config.sh
cp common.sh $HOME/.config/i3blocks/common.sh
cp blocks/* $HOME/.config/i3blocks/blocks/