vim.filetype.add({
  extension = {
    hlsl = "hlsl",
    slang = "slang",
  },
  pattern = {
    [".*%.tex%.mustache"] = "texmustache",
  },
})
