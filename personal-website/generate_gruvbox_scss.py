#!/usr/bin/env python3
import json
from pathlib import Path
from typing import List

cur_dir: Path = Path(__file__).parent
top_dir: Path = cur_dir.parent
colors_json: Path = top_dir.joinpath("colors", "gruvbox.json")

if __name__ == "__main__":
    with colors_json.open() as f:
        colors = json.loads(f.read())
    print("$gruvbox-colors: (")
    items: List[str] = []
    for key, value in colors["dark"].items():
        items.append(f"  {key}: #{value}")
    print(",\n".join(items))
    print(")")