#!/usr/bin/env python3
import sys
import re

color_enabled = sys.argv[1]
color_disabled = sys.argv[2]
icons = {
    'wifi': 'W',
    'wireguard': 'W'
}

statuses = []

for line in sys.stdin:
    _, type, state, _ = line.split(':')
    if type not in icons:
        continue
    is_connected = state.startswith('connected')
    icon = icons[type]
    color = color_enabled if is_connected else color_disabled
    if is_connected or type == 'wifi':
        statuses.append(f'<span fgcolor="{color}">{icon}</span>')

print(' '.join(statuses))
