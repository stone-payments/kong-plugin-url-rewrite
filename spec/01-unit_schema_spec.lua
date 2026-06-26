local PLUGIN_NAME = "url-rewrite"

-- helper that validates a `config` table against the plugin schema
local validate do
  local validate_entity = require("spec.helpers").validate_plugin_config_schema
  local plugin_schema = require("kong.plugins." .. PLUGIN_NAME .. ".schema")

  function validate(config)
    return validate_entity(config, plugin_schema)
  end
end

describe("Test #unit schema", function()

  describe("config.url", function()

    it("accepts a plain path", function()
      local ok, err = validate({ url = "/test" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("accepts the root path", function()
      local ok, err = validate({ url = "/" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("accepts a path with a single placeholder", function()
      local ok, err = validate({ url = "/baz/<bar>" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("accepts a path with multiple placeholders", function()
      local ok, err = validate({ url = "/foo/<a>/bar/<b>" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("accepts RFC 3986 sub-delims and percent-encoded values", function()
      local ok, err = validate({ url = "/foo%20bar/a,b;c=d" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("rejects a path without a leading slash", function()
      local ok, err = validate({ url = "new_url" })
      assert.is_falsy(ok)
      assert.matches("invalid path", err.config.url)
    end)

    it("rejects a path with a leading-slash-less placeholder", function()
      local ok, err = validate({ url = "new_url/<bar>" })
      assert.is_falsy(ok)
      assert.matches("invalid path", err.config.url)
    end)

    it("rejects a full URL (does not start with a slash)", function()
      local ok, err = validate({ url = "http://new-url.com" })
      assert.is_falsy(ok)
      assert.matches("invalid path", err.config.url)
    end)

    it("rejects characters outside the RFC 3986 reserved list", function()
      local ok, err = validate({ url = "/foo bar" })
      assert.is_falsy(ok)
      assert.matches("invalid path", err.config.url)
    end)

    it("rejects malformed percent-encoding", function()
      local ok, err = validate({ url = "/foo%2" })
      assert.is_falsy(ok)
      assert.matches("invalid url%-encoded value", err.config.url)
    end)

    it("is required", function()
      local ok, err = validate({})
      assert.is_falsy(ok)
      assert.matches("required field missing", err.config.url)
    end)

  end)

  describe("config.query_string", function()

    it("accepts an array of strings alongside a valid url", function()
      local ok, err = validate({
        url = "/test",
        query_string = { "code_parameter=<code_parameter>", "parameter2=abcdef" },
      })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

    it("is optional", function()
      local ok, err = validate({ url = "/test" })
      assert.is_nil(err)
      assert.is_truthy(ok)
    end)

  end)

end)
