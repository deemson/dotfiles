import json
from pathlib import Path
from typing import List

cur_dir: Path = Path(__file__).parent
top_dir: Path = cur_dir.parent
colors_dir: Path = top_dir.joinpath("colors")
with colors_dir.joinpath("gruvbox.json").open() as f:
    gruvbox_colors = json.load(f)
lines: List[str] = []
for key, value in gruvbox_colors["dark"].items():
    lines.append("col_" + key + "='#" + value + "'")
with cur_dir.joinpath("colors.sh").open("w") as f:
    f.write("\n".join(lines))