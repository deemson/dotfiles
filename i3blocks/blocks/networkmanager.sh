#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

nmstatus=$(nmcli --terse --color no device | $HOME/.config/i3blocks/blocks/networkmanager.py $col_fg $col_bg1)
printf "$lsep <span fgcolor=\"$col_fg4\">NET</span> $nmstatus $rsep\\n"
