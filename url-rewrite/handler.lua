local BasePlugin = require "kong.plugins.base_plugin"
local cjson_decode = require('cjson').decode

local req_read_body = ngx.req.read_body
local req_get_body_data = ngx.req.get_body_data

local URLRewriter = BasePlugin:extend()

URLRewriter.PRIORITY = 700

function split(s, delimiter)
  result = {}
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
  end
  return result
end

function isBodyPattern(paramValue)
  local bodyUrlParamPattern = "^body:"
  return paramValue:find(bodyUrlParamPattern) ~= nil
end

function URLRewriter:new()
  URLRewriter.super.new(self, "url-rewriter")
end


function resolveUrlParams(requestParams, url)
  for paramValue in requestParams do
    if isBodyPattern(paramValue) then
      local body = nil
      local data = kong.request.get_body()

      if data then
        body = cjson_decode(data)
      end

      local splitted = split(paramValue, ':')
      url = url:gsub("<" .. paramValue .. ">", body[splitted[2]])
    else
      local requestParamValue = ngx.ctx.router_matches.uri_captures[paramValue]
      
      if type(requestParamValue) == 'string' then
        requestParamValue = requestParamValue:gsub("%%", "%%%%")
      end

      url = url:gsub("<" .. paramValue .. ">", requestParamValue)
    end

    
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
