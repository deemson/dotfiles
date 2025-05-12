import * as path from "node:path";
import * as fs from "node:fs/promises";

const dotfilesDir = path.dirname(path.dirname(path.resolve(import.meta.dirname)));
const filePath = path.join(dotfilesDir, "colors", "morhetz-gruvbox", "gruvbox-transformed.json");

type Cell = [string, string];
type Row = Cell[];

(async () => {
  const fileData = await fs.readFile(filePath);
  const gruvboxJSON = JSON.parse(fileData.toString()).dark;
  console.log(
    gruvboxJSON
      .map((row: Row) => {
        return row
          .map(([name, value]) => {
            return `set $col_${name} #${value}`;
          })
          .join("\n");
      })
      .join("\n\n"),
  );
})();
