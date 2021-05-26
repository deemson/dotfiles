#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

nmstatus=$(nmcli --terse --color no device | $HOME/.config/i3blocks/blocks/networkmanager.py $col_fg $col_bg1)
printf "$lsep $nmstatus $rsep\\n"