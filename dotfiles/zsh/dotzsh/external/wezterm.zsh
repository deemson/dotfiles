function wezname {
    echo "\x1b]1337;SetUserVar=pane_title=$(echo -n $1 | base64)\x07"
}
