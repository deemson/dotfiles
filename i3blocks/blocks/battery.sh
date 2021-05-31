#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

bat_icon_full=
bat_icon_three_quarters=
bat_icon_half=
bat_icon_quarter=
bat_icon_empty=
ac_icon=
batstatus=""

for entry in /sys/class/power_supply/*; do
    if [[ $(basename $entry) == "BAT"* ]]; then
        battery=$(cat $entry/capacity)
        if (($battery == 100)); then
            battery=..
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
        battery=$(printf %02d $battery)
        batstatus+=" $bicon $battery"
    fi
done
ac=$(cat /sys/class/power_supply/AC/online)
if (($ac == 1)); then
    ac_color=$col_fg
else
    ac_color=$col_bg1
fi
printf "$lsep$batstatus <span fgcolor=\"$ac_color\">$ac_icon</span> $rsep\\n"
