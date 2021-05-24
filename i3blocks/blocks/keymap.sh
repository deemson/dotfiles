#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

icon=
layout=$(setxkbmap -query | grep layout | sed --regexp-extended 's/layout: +([a-zA-Z]+)/\1/')
case $layout in
us)
    text=EN
    col=$col_green
    ;;
ru)
    text=RU
    col=$col_blue
    ;;
ua)
    text=UA
    col=$col_yellow
    ;;
de)
    text=DE
    col=$col_purple
    ;;
esac
printf "$lsep $icon <span fgcolor=\"$col\">$text</span> $rsep\\n"