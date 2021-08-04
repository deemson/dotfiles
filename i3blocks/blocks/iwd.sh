#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

iwdstatus=$(iwctl station wlan0 show | $HOME/.config/i3blocks/blocks/iwd.py $col_fg $col_bg1)
printf "$lsep <span fgcolor=\"$col_fg4\">WiFi</span> $iwdstatus $rsep\\n"
