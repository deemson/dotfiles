#!/usr/bin/env sh

source $HOME/.config/i3blocks/colors.sh
source $HOME/.config/i3blocks/common.sh

bluetooth_icon=
btstatus=""

while read -r mac_address; do
    btstatus+=$(bluetoothctl info $mac_address | $HOME/.config/i3blocks/blocks/bluetooth_info.py $col_fg $col_bg1)
done <<<$(bluetoothctl devices | awk '{ print $2 }')

printf "$lsep $bluetooth_icon$btstatus $rsep\\n"