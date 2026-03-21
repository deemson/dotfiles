import { Command } from "commander";
import { loadCurrentProfile } from "@/config";
import { ProfileCopier } from "@/copier";
import { logger } from "@/lib/logging";

const loadProfileCopier = async () => {
  const profile = await loadCurrentProfile();
  logger.info({ profile: profile.name }, "loaded profile");
  return new ProfileCopier(profile);
};

export const saveCommand = new Command("save");

const addOptions = (command: Command): Command => {
  return command.option("-d, --dry", "dry run").option("-v, --verbose", "verbose output");
};

addOptions(saveCommand).action(async () => {
  const { dry, verbose }: { dry: boolean; verbose: boolean } = saveCommand.opts();
  const copier = await loadProfileCopier();
  const report = await copier.save(dry);
  const lines = report.render(verbose);
  logger.info({}, "save report\n" + lines.join("\n"));
});

export const loadCommand = new Command("load");

addOptions(loadCommand).action(async () => {
  const { dry, verbose }: { dry: boolean; verbose: boolean } = loadCommand.opts();
  const copier = await loadProfileCopier();
  const report = await copier.load(dry);
  const lines = report.render(verbose);
  logger.info({}, "load report\n" + lines.join("\n"));
});
