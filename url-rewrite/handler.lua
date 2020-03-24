local BasePlugin = require "kong.plugins.base_plugin"

local URLRewriter = BasePlugin:extend()

URLRewriter.PRIORITY = 700

function split(s, delimiter)
  result = {}
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
  end
  return result
end

function URLRewriter:new()
  URLRewriter.super.new(self, "url-rewriter")
end

function resolveUrlParams(requestParams, url)
  for paramValue in requestParams do
    local requestParamValue = ngx.ctx.router_matches.uri_captures[paramValue]
    if type(requestParamValue) == string
      requestParamValue = requestParamValue:gsub("%%", "%%%%")
    url = url:gsub("<" .. paramValue .. ">", requestParamValue)
  end
  return url
end

function getRequestUrlParams(url)
  return string.gmatch(url, "<(.-)>")
end

function URLRewriter:access(config)
  URLRewriter.super.access(self)

  if config.query_string ~= nil then
    local args = ngx.req.get_uri_args()
    for k, queryString in ipairs(config.query_string) do
      local splitted = split(queryString, '=')
      local key, value = splitted[1], splitted[2]
      local queryParams = getRequestUrlParams(value)
      local resolvedParams = resolveUrlParams(queryParams, value)
      args[key] = resolvedParams
    end
    ngx.req.set_uri_args(args)
  end

  requestParams = getRequestUrlParams(config.url)
  local url = resolveUrlParams(requestParams, config.url)
  ngx.var.upstream_uri = url
end

return URLRewriter
