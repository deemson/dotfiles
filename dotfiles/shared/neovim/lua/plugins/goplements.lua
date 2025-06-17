-- goplements shows implemented interfaced and implementing structs for Go types
return {
  "maxandron/goplements.nvim",
  ft = "go",
  opts = {
    prefix = {
      interface = "implemented by: ",
      struct = "implements: ",
    },
    display_package = true,
    namespace_name = "goplements",
    highlight = "Goplements",
  },
}
