#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

parts=($(date +'%d %b %a'))
printf "$lsep ${parts[0]} ${parts[1]} <span fgcolor=\"$col_fg4\">${parts[2]}</span> $rsep\\n"