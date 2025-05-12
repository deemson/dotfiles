import path from "node:path";

const tempHomeDir = process.env["HOME"];
if (tempHomeDir === undefined || tempHomeDir === null || tempHomeDir === "") {
  throw new Error("$HOME env var is empty");
}
export const homeDir = tempHomeDir;

export const libDir = path.resolve(import.meta.dirname);
export const srcDir = path.dirname(libDir);
export const cliDir = path.dirname(srcDir);
export const topDir = path.dirname(cliDir);
export const dotfilesDir = path.join(topDir, "dotfiles");
