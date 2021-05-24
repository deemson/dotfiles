#!/usr/bin/env sh

layout=$(setxkbmap -query | grep layout | sed --regexp-extended 's/layout: +([a-zA-Z]+)/\1/')
case $layout in
us)
    text=EN
    ;;
ru)
    text=RU
    ;;
ua)
    text=UA
    ;;
de)
    text=DE
    ;;
esac
printf "[  $text ]\\n"