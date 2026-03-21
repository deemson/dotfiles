import { program } from "commander";
import { configCommand } from "@/cmd/config";
import { saveCommand, loadCommand } from "@/cmd/save-load";

program.addCommand(configCommand);
program.addCommand(saveCommand);
program.addCommand(loadCommand);

program.parse();
