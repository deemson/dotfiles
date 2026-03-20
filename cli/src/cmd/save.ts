import { Command } from "commander";
import { loadCurrentProfile } from "@/lib/config";

export const saveCommand = new Command("save");

saveCommand.action(async () => {
  console.log(JSON.stringify(await loadCurrentProfile(), null, 2));
});
