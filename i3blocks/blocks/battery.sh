#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh

bat_icon_full=
bat_icon_three_quarters=
bat_icon_half=
bat_icon_quarter=
bat_icon_empty=
ac_icon=

battery=$(cat /sys/class/power_supply/BAT0/capacity)
if (($battery == 100)); then
    battery=FF
    bicon=$bat_icon_full
elif (($battery > 90)); then
    bicon=$bat_icon_full
elif (($battery > 60)); then
    bicon=$bat_icon_three_quarters
elif (($battery > 40)); then
    bicon=$bat_icon_half
elif (($battery > 10)); then
    bicon=$bat_icon_quarter
else
    bicon=$bat_icon_empty
fi
ac=$(cat /sys/class/power_supply/AC/online)
if (($ac == 1)); then
    ac_color=$col_fg
else
    ac_color=$col_bg2
fi
printf "[ $bicon $battery <span fgcolor=\"$ac_color\">$ac_icon</span> ]\\n"