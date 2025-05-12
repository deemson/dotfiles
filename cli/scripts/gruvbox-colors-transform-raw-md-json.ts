import * as path from "node:path";
import * as fs from "node:fs/promises";

const dotfilesDir = path.dirname(path.dirname(path.resolve(import.meta.dirname)));
const colorsDir = path.join(dotfilesDir, "colors", "morhetz-gruvbox");
const inPath = path.join(colorsDir, "gruvbox-for-md.json");
const outPath = path.join(colorsDir, "gruvbox-transformed.json");

type Cell = [string, string];
type Row = Cell[];

const transformColorArrays = (rows: Row[]): Row[] => {
  return rows.map((row: Row, iRow: number) => {
    return row
      .filter(([name, _]) => {
        const isNamePresent = !!name;
        const isSecondGray = iRow === 2 && name === "gray";
        return isNamePresent && !isSecondGray;
      })
      .map(([name, value]) => {
        let correctedName = name;
        if (iRow < 2 && !(name === "fg" || name === "bg")) {
          correctedName += iRow + 1;
        }
        if (name === "orange") {
          correctedName += iRow - 1;
        }
        return [correctedName, value];
      });
  });
};

(async () => {
  const fileData = await fs.readFile(inPath);
  const { dark, light } = JSON.parse(fileData.toString());
  const transformed = {
    dark: transformColorArrays(dark),
    light: transformColorArrays(light),
  };
  await fs.writeFile(outPath, JSON.stringify(transformed));
})();
