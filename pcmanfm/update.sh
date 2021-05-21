#!/usr/bin/env sh

set -x
# Set window width & height to certain hardcoded values
# It is required because PCManFM keeps changing those on every app exit
# and config keeps changing in git repo because of that
cat $HOME/.config/pcmanfm/default/pcmanfm.conf | sed 's/win_width=.*/win_width=640/; s/win_height=.*/win_heigh=480/' >pcmanfm.conf