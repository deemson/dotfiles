import z from "zod";

const pathSchema = z.strictObject({
  system: z.string().min(1),
  repo: z.string().min(1),
});

const appConfigPathSchema = z
  .string()
  .min(1)
  // exactly two non-empty, slash-free segments: "os/app", e.g. "posix/neovim".
  // resolves to config/apps/<os>/<app>.yaml, so no leading/trailing slash,
  // no deeper nesting, and no bare app name without an os dir.
  .regex(/^[^/]+\/[^/]+$/);

const envConfigSchemaTemporary = z.strictObject({
  inherit: z.array(z.string().min(1)).min(1).optional(),
  abstract: z.boolean().optional(),
  apps: z.array(appConfigPathSchema).min(1).optional(),
});

export const envConfigJsonSchema = envConfigSchemaTemporary.toJSONSchema({ target: "draft-2020-12" });

export const envConfigSchema = envConfigSchemaTemporary.transform((v) => {
  return {
    ...v,
    abstract: !!v.abstract,
    inherit: v.inherit || [],
    apps: v.apps || [],
  };
});

export const appConfigSchema = z.array(pathSchema).min(1);
export const appConfigJsonSchema = appConfigSchema.toJSONSchema({ target: "draft-2020-12" });
