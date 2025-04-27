import { pino } from "pino";

export const logger = pino({
  transport: {
    target: "pino-pretty",
    options: {
      singleLine: true,
      ignore: "pid,hostname",
    },
  },
});
logger.level = "debug";

