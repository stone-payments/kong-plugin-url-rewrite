package = "kong-url-rewrite-plugin"
version = "0.1.0-1"
source = {
   url = "https://github.com/stone-payments/kong-plugin-url-rewrite",
}
description = {
  summary = "KongAPI Gateway middleware plugin for url-rewrite purposes.",
  license = "Apache License 2.0"
}
dependencies = {
  "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
    ["kong.plugins.kong-url-rewrite-plugin.handler"] = "./handler.lua",
    ["kong.plugins.kong-url-rewrite-plugin.schema"] = "./schema.lua"
   }
}
