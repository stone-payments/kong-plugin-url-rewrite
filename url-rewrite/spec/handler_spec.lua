-- Mock ngx
local ngx =  {
    log = spy.new(function() end),
    var = {
        upstream_uri = "mock"
    }
}
_G.ngx = ngx

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
end)
