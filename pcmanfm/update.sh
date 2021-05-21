#!/usr/bin/env sh

set -x
cat $HOME/.config/pcmanfm/default/pcmanfm.conf | sed 's/win_width=.*/win_width=640/; s/win_height=.*/win_heigh=480/' >pcmanfm.conf