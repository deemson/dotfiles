import { homeDir } from "@/lib/paths";
import fs from "node:fs/promises";
import path from "node:path";
import { CopyReport } from "@/copier/report";

export const resolvePath = (p: string): string => {
  if (p.startsWith("$HOME")) {
    return path.join(homeDir, p.slice("$HOME".length));
  }
  return p;
};

const allPathStatuses = ["absent", "directory", "file"] as const;
export type PathStatus = (typeof allPathStatuses)[number];

export const getPathStatus = async (p: string): Promise<PathStatus> => {
  try {
    const stat = await fs.stat(p);
    return stat.isDirectory() ? "directory" : "file";
  } catch (e) {
    if (e instanceof Error && (e as NodeJS.ErrnoException).code === "ENOENT") {
      return "absent";
    }
    throw e;
  }
};

export const getPathStatuses = async (...ps: string[]): Promise<PathStatus[]> => {
  return Promise.all(ps.map((p) => getPathStatus(p)));
};

export const copyFile = async (srcPath: string, dstPath: string, dry: boolean): Promise<CopyReport> => {
  if (!dry) {
    await fs.copyFile(srcPath, dstPath);
  }
  return new CopyReport(srcPath, dstPath, []);
};

export const copyDir = async (srcDir: string, dstDir: string, dry: boolean): Promise<CopyReport> => {
  const children: CopyReport[] = [];
  const items = await fs.readdir(srcDir);
  if (!dry) {
    await fs.mkdir(dstDir, { recursive: true });
  }
  for (const item of items) {
    const srcPath = path.join(srcDir, item);
    const dstPath = path.join(dstDir, item);
    const isDirItem = (await fs.stat(srcPath)).isDirectory();
    if (isDirItem) {
      children.push(await copyDir(srcPath, dstPath, dry));
    } else {
      children.push(await copyFile(srcPath, dstPath, dry));
    }
  }
  return new CopyReport(srcDir, dstDir, children);
};
