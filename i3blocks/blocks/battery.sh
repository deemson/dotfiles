#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

batstatus=""

for entry in /sys/class/power_supply/*; do
    if [[ $(basename $entry) == "BAT"* ]]; then
        battery=$(cat $entry/capacity)
        if (($battery == 100)); then
            battery=..
            bcol=$col_blue
        elif (($battery > 90)); then
            bcol=$col_blue
        elif (($battery > 60)); then
            bcol=$col_green
        elif (($battery > 40)); then
            bcol=$col_yellow
        elif (($battery > 10)); then
            bcol=$col_orange
        else
            bcol=$col_red
        fi
        battery=$(printf %02d $battery)
        st=$(cat $entry/status)
        case $st in
        Charging)
            stsym="+"
            stcol=$col_green
            ;;
        Discharging)
            stsym="-"
            stcol=$col_red
            ;;
        *)
            stsym="?"
            stcol=$col_bg4
            ;;
        esac
        batstatus+=" <span fgcolor=\"$bcol\">$battery</span><span fgcolor=\"$stcol\">$stsym</span>"
    fi
done
ac=$(cat /sys/class/power_supply/AC/online)
if (($ac == 1)); then
    ac_color=$col_fg
else
    ac_color=$col_bg1
fi
printf "$lsep$batstatus <span fgcolor=\"$ac_color\">.</span> $rsep\\n"
