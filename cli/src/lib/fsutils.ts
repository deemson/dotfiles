import fs from "node:fs/promises";
import path from "node:path";

export const copyDirContents = async (srcDir: string, dstDir: string) => {
  const items = await fs.readdir(srcDir);
  await fs.mkdir(dstDir, { recursive: true });
  for (const item of items) {
    const srcPath = path.join(srcDir, item);
    const dstPath = path.join(dstDir, item);
    const isDirItem = (await fs.stat(srcPath)).isDirectory();
    if (isDirItem) {
      await copyDirContents(srcPath, dstPath);
    } else {
      await fs.copyFile(srcPath, dstPath);
    }
  }
};
