#!/usr/bin/env python3
import sys
import re

color_enabled = sys.argv[1]
color_disabled = sys.argv[2]

color = color_disabled
text = '?'
for line in sys.stdin:
    stripped_line = line.strip()
    parts = [part.strip() for part in stripped_line.split(' ') if part]
    if parts and parts[0] == 'State':
        if parts[1] == 'connected':
            color = color_enabled
            text = 'C'
        elif parts[1] == 'disconnected':
            text = 'D'
        break
print(f'<span fgcolor="{color}">{text}</span>')