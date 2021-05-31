#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

parts=($(date +'%H %M'))
printf "$lsep ${parts[0]}<span fgcolor=\"$col_fg4\">:</span>${parts[1]} $rsep\\n"