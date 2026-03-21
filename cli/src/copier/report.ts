import chalk from "chalk";

const indent = "  ";

const allReportStatuses = ["ok", "error"] as const;
type ReportStatus = (typeof allReportStatuses)[number];

const renderStatus = (status: ReportStatus): string => {
  let symbol = "?";
  switch (status) {
    case "ok":
      symbol = chalk.green("o");
      break;
    case "error":
      symbol = chalk.red("x");
      break;
  }
  return `[${symbol}]`;
};

export class CopyReport {
  constructor(
    private readonly source: string,
    private readonly destination: string,
    private readonly children: CopyReport[],
  ) {}

  render(): string[] {
    const lines = [chalk.blackBright(`${this.source} -> ${this.destination}`)];
    for (const child of this.children) {
      lines.push(...child.render().map((v) => indent + v));
    }
    return lines;
  }
}

export class PathReport {
  constructor(
    private readonly status: ReportStatus,
    private readonly name: string,
    private readonly description: string,
    private readonly copy: CopyReport | undefined,
  ) {}

  render(verbose: boolean): string[] {
    const lines = [[renderStatus(this.status), chalk.blue(this.name) + ":", this.description].join(" ")];
    if (this.copy !== undefined && verbose) {
      lines.push(...this.copy.render());
    }
    return lines;
  }
}

export class AppReport {
  constructor(
    private readonly name: string,
    private readonly paths: PathReport[],
  ) {}

  render(verbose: boolean): string[] {
    const lines = [chalk.magenta(this.name) + ":"];
    for (const path of this.paths) {
      lines.push(...path.render(verbose).map((v) => indent + v));
    }
    return lines;
  }
}

export class ProfileReport {
  constructor(private readonly apps: AppReport[]) {}

  render(verbose: boolean): string[] {
    const lines: string[] = [];
    for (const app of this.apps) {
      lines.push(...app.render(verbose));
    }
    return lines;
  }
}
