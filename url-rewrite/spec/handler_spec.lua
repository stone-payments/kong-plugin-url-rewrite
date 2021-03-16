-- Mock kong
local kong = {
  request = {
    get_body = spy.new(function() return {} end),
  }
}
-- Mock ngx
local ngx =  {
    log = spy.new(function() end),
    var = {
        upstream_uri = "mock"
    },
    ctx = {
      router_matches = {
        uri_captures = {}
      }
    },
    req = {
      get_uri_args = spy.new(function() return {} end),
      set_uri_args = spy.new(function() end)
    }
}

_G.ngx = ngx
_G.kong = kong

local URLRewriter = require('../handler')

describe("TestHandler", function()

  it("should test handler constructor", function()
    URLRewriter:new()
    assert.equal('url-rewriter', URLRewriter._name)
  end)

  it("should test rewrite of upstream_uri", function()
    URLRewriter:new()
    assert.equal('mock', ngx.var.upstream_uri)
    config = {
        url = "new_url"
    }
    URLRewriter:access(config)
    assert.equal('new_url', ngx.var.upstream_uri)
  end)

  it("should test rewrite of upstream_uri with params", function()
    URLRewriter:new()
    ngx.ctx.router_matches.uri_captures["code_parameter"] = "123456"
    config = {
        url = "new_url/<code_parameter>"
    }
    URLRewriter:access(config)
    assert.equal('new_url/123456', ngx.var.upstream_uri)
  end)

  it("should replace url params", function()
    URLRewriter:new()
    local mockUrl = "url/<param1>/<param2>"
    local iter = getRequestUrlParams(mockUrl)
    ngx.ctx.router_matches.uri_captures["param1"] = 123456
    ngx.ctx.router_matches.uri_captures["param2"] = "test"

    local result = resolveUrlParams(iter, mockUrl)

    assert.equal("url/123456/test", result)
  end)
  
  it("should replace url params with special character", function()
    URLRewriter:new()
    local mockUrl = "url/<param1>/<param2>"
    local iter = getRequestUrlParams(mockUrl)
    ngx.ctx.router_matches.uri_captures["param1"] = "test%23special%2fcharacter"
    ngx.ctx.router_matches.uri_captures["param2"] = "test%2bspecial%3fcharacter"

    local result = resolveUrlParams(iter, mockUrl)

    assert.equal("url/test%23special%2fcharacter/test%2bspecial%3fcharacter", result)
  end)

  it("should add querystring params when schema has query_string field", function()
    URLRewriter:new()
    ngx.ctx.router_matches.uri_captures["code_parameter"] = "123456"
    config = {
        url = "new_url",
        query_string = {
          "code_parameter=<code_parameter>",
          "parameter2=abcdef",
        }
    }
    URLRewriter:access(config)
    local expected = {
      code_parameter = "123456",
      parameter2 = "abcdef",
    }
    assert.spy(ngx.req.set_uri_args).was_called_with(expected)
  end)

  it("should replace url params with the body value", function ()
    URLRewriter:new()

    kong.request.get_body = function ()
      return '{"information": "00001111"}'
    end
    
    config = {
      url = "new_url/<body:information>",
    }

    URLRewriter:access(config)
    assert.equal('new_url/00001111', ngx.var.upstream_uri)
  end)
end)
