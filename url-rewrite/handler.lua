local BasePlugin = require "kong.plugins.base_plugin"

local URLRewriter = BasePlugin:extend()

URLRewriter.PRIORITY = 700

function URLRewriter:new()
  URLRewriter.super.new(self, "url-rewriter")
end

function URLRewriter:access(config)
  URLRewriter.super.access(self)
  ngx.var.upstream_uri = config.url
end

return URLRewriter
