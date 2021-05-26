#!/usr/bin/env python3
import sys

icons = {
    'audio-card': ''
}

color_enabled = sys.argv[1]
color_disabled = sys.argv[2]
is_shown_anyway = False
is_connected = False
icon = ''

for line in sys.stdin:
    stripped_line = line.strip()
    if stripped_line.startswith('Name'):
        is_shown_anyway = 'deemson bose' in stripped_line
    elif stripped_line.startswith('Connected'):
        is_connected = stripped_line.split(':')[1].strip() == 'yes'
    elif stripped_line.startswith('Icon'):
        icon_key = stripped_line.split(':')[1].strip()
        if icon_key in icons:
            icon = icons[icon_key]

color = color_enabled if is_connected else color_disabled
if is_connected or is_shown_anyway:
    print(f' <span fgcolor="{color}">{icon}</span>')
else:
    print('')