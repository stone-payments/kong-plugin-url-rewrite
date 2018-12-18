local BasePlugin = require "kong.plugins.base_plugin"

local URLRewriter = BasePlugin:extend()

URLRewriter.PRIORITY = 700

function URLRewriter:new()
  URLRewriter.super.new(self, "url-rewriter")
end

function resolveUrlParams(requestParams, url)
  for param in requestParams do
    requestParamValue = ngx.ctx.router_matches.uri_captures[param]
    newUrl = url:gsub("<" .. param .. ">", requestParamValue)
  end
  return newUrl
end

function URLRewriter:access(config)
  URLRewriter.super.access(self)
  requestParams = string.gmatch(config.url, "<(.-)>") -- Returns all requests params from url.
  ngx.var.upstream_uri = resolveUrlParams(requestParams, config.url)
end

return URLRewriter
