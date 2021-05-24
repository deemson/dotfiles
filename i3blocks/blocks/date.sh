#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

icon=
parts=($(date +'%d %b %a'))
printf "$lsep $icon <span fgcolor=\"$col_blue\">${parts[0]} ${parts[1]}</span> <span fgcolor=\"$col_purple\">${parts[2]}</span> $rsep\\n"