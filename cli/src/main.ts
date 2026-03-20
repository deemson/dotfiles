import { program } from "commander";
import { configCommand } from "./cmd/config";
import { saveCommand } from "./cmd/save";

program.addCommand(configCommand);
program.addCommand(saveCommand);

program.parse();
