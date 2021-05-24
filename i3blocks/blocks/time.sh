#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

icon=
parts=($(date +'%H %M'))
printf "$lsep $icon <span fgcolor=\"$col_blue\">${parts[0]}</span><span fgcolor=\"$col_bg4\">:</span><span fgcolor=\"$col_aqua\">${parts[1]}</span> $rsep\\n"