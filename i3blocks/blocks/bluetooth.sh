#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

declare bt_col
bluetooth_icon=
btstatus=""

if bluetoothctl show | grep Powered | grep yes >/dev/null; then
    bt_col=$col_fg
else
    bt_col=$col_bg1
fi

while read -r mac_address; do
    btstatus+=$(bluetoothctl info $mac_address | $HOME/.config/i3blocks/blocks/bluetooth_info.py $col_fg $col_bg1)
done <<<$(bluetoothctl devices | awk '{ print $2 }')

printf "$lsep <span fgcolor=\"$bt_col\">$bluetooth_icon</span>$btstatus $rsep\\n"