import z from "zod";

const pathSchema = z.strictObject({
  system: z.string().min(1),
  repo: z.string().min(1),
});

const appSchema = z.strictObject({
  name: z.string().min(1),
  paths: z.array(pathSchema).min(1),
});

const tempConfigSchema = z.strictObject({
  inherit: z.array(z.string().min(1)).min(1).optional(),
  abstract: z.boolean().optional(),
  apps: z.array(appSchema).min(1),
});

export const configJsonSchema = tempConfigSchema.toJSONSchema({ target: "draft-2020-12" });

export const configSchema = tempConfigSchema.transform((v) => {
  return {
    ...v,
    abstract: !!v.abstract,
    inherit: v.inherit || [],
  };
});
