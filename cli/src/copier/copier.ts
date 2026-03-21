import fs from "node:fs/promises";
import path from "node:path";
import { ProfilePath, ProfileApp, Profile } from "@/config";
import { getPathStatus, getPathStatuses, resolvePath, copyDir, copyFile } from "@/copier/copier-helpers";
import { dotfilesDir } from "@/lib/paths";
import { CopyReport, PathReport, AppReport, ProfileReport } from "@/copier/report";

class PathCopier {
  private readonly systemPath: string;
  private readonly repoPath: string;

  constructor(
    private readonly config: ProfilePath,
    prefix: string,
  ) {
    this.systemPath = path.resolve(resolvePath(config.system));
    this.repoPath = path.resolve(path.join(dotfilesDir, prefix, config.repo));
  }

  async save(dry: boolean): Promise<PathReport> {
    let name = this.config.system;
    let copy: CopyReport | undefined = undefined;
    const [systemStatus, repoStatus] = await getPathStatuses(this.systemPath, this.repoPath);
    console.log(this.repoPath, repoStatus);
    if (systemStatus === "absent") {
      return new PathReport("error", name, "does not exist", undefined);
    }
    if (systemStatus === "directory" && repoStatus === "file") {
      return new PathReport("error", name, `is a directory and ${this.config.repo} is a file`, copy);
    }
    if (systemStatus === "file" && repoStatus === "directory") {
      return new PathReport("error", name, `is a file and ${this.config.repo} is a directory`, copy);
    }
    let description = "copying";
    if (repoStatus === "directory") {
      name += "/";
      description = "cleaning & copying";
      if (!dry) {
        await fs.rm(this.repoPath, { recursive: true, force: true });
      }
    }
    if (systemStatus === "directory") {
      copy = await copyDir(this.systemPath, this.repoPath, dry);
    } else if (systemStatus === "file") {
      copy = await copyFile(this.systemPath, this.repoPath, dry);
    }
    return new PathReport("ok", name, description, copy);
  }

  async load(dry: boolean): Promise<PathReport> {
    let name = this.config.repo;
    let copy: CopyReport | undefined = undefined;
    const [systemStatus, repoStatus] = await getPathStatuses(this.systemPath, this.repoPath);
    if (repoStatus === "absent") {
      return new PathReport("error", name, "does not exist", undefined);
    }
    if (systemStatus === "directory" && repoStatus === "file") {
      return new PathReport("error", name, `is a file and ${this.config.system} is a directory`, copy);
    }
    if (systemStatus === "file" && repoStatus === "directory") {
      return new PathReport("error", name, `is a directory and ${this.config.system} is a file`, copy);
    }
    let description = "copying";
    if (systemStatus === "directory") {
      name += "/";
      description = "cleaning & copying";
      if (!dry) {
        await fs.rm(this.systemPath, { recursive: true, force: true });
      }
    }
    if (repoStatus === "directory") {
      copy = await copyDir(this.repoPath, this.systemPath, dry);
    } else if (repoStatus === "file") {
      if (!dry) {
        await fs.mkdir(path.dirname(this.systemPath), { recursive: true });
      }
      copy = await copyFile(this.repoPath, this.systemPath, dry);
    }
    return new PathReport("ok", name, description, copy);
  }
}

class AppCopier {
  private readonly paths: PathCopier[];
  private readonly repoPath: string;

  constructor(private readonly config: ProfileApp) {
    this.paths = config.paths.map((pathConfig) => {
      return new PathCopier(pathConfig, path.join(config.config, config.name));
    });
    this.repoPath = path.resolve(path.join(dotfilesDir, config.config, config.name));
  }

  async save(dry: boolean): Promise<AppReport> {
    if (!dry) {
      const repoStatus = await getPathStatus(this.repoPath);
      if (repoStatus !== "absent") {
        await fs.rm(this.repoPath, { recursive: true, force: true });
      }
      await fs.mkdir(this.repoPath, { recursive: true });
    }
    const pathReports = await Promise.all(this.paths.map((p) => p.save(dry)));
    return new AppReport(this.config.name, pathReports);
  }

  async load(dry: boolean): Promise<AppReport> {
    const pathReports = await Promise.all(this.paths.map((p) => p.load(dry)));
    return new AppReport(this.config.name, pathReports);
  }
}

export class ProfileCopier {
  private readonly apps: AppCopier[];

  constructor(config: Profile) {
    this.apps = config.apps.map((appConfig) => {
      return new AppCopier(appConfig);
    });
  }

  async save(dry: boolean): Promise<ProfileReport> {
    const appReports = await Promise.all(this.apps.map((a) => a.save(dry)));
    return new ProfileReport(appReports);
  }

  async load(dry: boolean): Promise<ProfileReport> {
    const appReports = await Promise.all(this.apps.map((a) => a.load(dry)));
    return new ProfileReport(appReports);
  }
}
