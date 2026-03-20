import fs from "node:fs/promises";
import path from "node:path";
import { Profile, App as ProfileApp, Path as ProfilePath } from "@/lib/config";
import { homeDir, dotfilesDir } from "@/lib/paths";

const copy = async (srcPath: string, dstPath: string, isDryRun: boolean) => {
  const statPromises = [srcPath, dstPath].map((path) => fs.stat(path));
  const stats = await Promise.all(statPromises);
  const [isSrcDir, isDstDir] = stats.map((s) => s.isDirectory());
  if (isSrcDir && !isDstDir) {
  } else if (!isSrcDir && isDstDir) {
  }
};

const resolvePath = (p: string): string => {
  if (p.startsWith("$HOME")) {
    return path.join(homeDir, p.slice("$HOME".length));
  }
  return p;
};

const allPathStatuses = ["absent", "directory", "file"] as const;
type PathStatus = (typeof allPathStatuses)[number];

const getPathStatus = async (p: string): Promise<PathStatus> => {
  try {
    const stat = await fs.stat(p);
    return stat.isDirectory() ? "directory" : "file";
  } catch {
    return "absent";
  }
};

const getPathStatuses = async (...ps: string[]): Promise<PathStatus[]> => {
  return Promise.all(ps.map((p) => getPathStatus(p)));
};

class Path {
  private readonly systemPath: string;
  private readonly repoPath: string;

  constructor(
    private readonly config: ProfilePath,
    private readonly prefix: string,
  ) {
    this.systemPath = path.resolve(resolvePath(config.system));
    this.repoPath = path.resolve(path.join(dotfilesDir, prefix, config.repo));
  }

  // async a(systemStatus: PathStatus, repoStatus: PathStatus) {
  //   let msg: string | undefined = undefined;
  //   if (systemStatus === "directory" && repoStatus === "file") {
  //   }
  // }

  async save(isDryRun: boolean, isDebug: boolean): Promise<string[]> {
    const report: string[] = [];
    const [systemStatus, repoStatus] = await getPathStatuses(this.systemPath, this.repoPath);
    if (systemStatus === "absent") {
      report.push(`${this.config.system}: does not exist`);
      if (isDebug) {
        report.push(this.systemPath);
      }
      return report;
    }
    report.push(`${this.config.system}: copying`);
    if (repoStatus === "directory") {
    }
  }
}

class App {
  constructor(
    private readonly config: ProfileApp,
    private readonly prefix: string,
  ) {}
}

export class Copier {
  private readonly apps: App[];

  constructor(private readonly config: Profile) {
    this.apps = config.apps.map((appConfig) => new App());
  }
}
