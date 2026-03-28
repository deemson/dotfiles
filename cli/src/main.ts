import { program } from "commander";
import { configCommand } from "@/cmd/config";
import { saveCommand, loadCommand } from "@/cmd/save-load";
import { appsCommand } from "@/cmd/apps";

const commands = [configCommand, saveCommand, loadCommand, appsCommand];

for (const command of commands) {
  program.addCommand(command);
}

program.parse();
