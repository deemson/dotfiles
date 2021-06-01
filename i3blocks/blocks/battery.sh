#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

batstatus=""

for entry in /sys/class/power_supply/*; do
    if [[ $(basename $entry) == "BAT"* ]]; then
        battery=$(cat $entry/capacity)
        if (($battery == 100)); then
            battery=..
        else
            battery=$(printf %02d $battery)
        fi
        
        st=$(cat $entry/status)
        case $st in
        Charging)
            stsym="+"
            ;;
        Discharging)
            stsym="-"
            ;;
        *)
            stsym="?"
            ;;
        esac
        batstatus+=" <span fgcolor=\"$col_fg\">$battery</span><span fgcolor=\"$col_gray\">$stsym</span>"
    fi
done
ac=$(cat /sys/class/power_supply/AC/online)
if (($ac == 1)); then
    ac_color=$col_fg
else
    ac_color=$col_bg1
fi
printf "$lsep <span fgcolor=\"$col_fg4\">POW</span>$batstatus <span fgcolor=\"$ac_color\">AC</span> $rsep\\n"
