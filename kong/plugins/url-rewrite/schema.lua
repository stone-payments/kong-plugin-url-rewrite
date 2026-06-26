local typedefs = require 'kong.db.schema.typedefs'

-- Mirrors Kong's `validate_path` (kong/db/schema/typedefs.lua) so the rewritten
-- URL is checked against the RFC 3986 reserved character list and is required
-- to start with a forward slash. The only accommodation for this plugin's
-- templating semantics is that `<param>` placeholders are replaced with a dummy
-- segment before validation, since the captured RegEx values are only known at
-- runtime.
local function validate_rewrite_path(path)
  -- replace `<param>` placeholders with a dummy value so the resulting
  -- string can be validated as a real path
  local resolved = path:gsub("<[^>]*>", "foo")

  if not resolved:match("^/[%w%.%-%_%~%/%%%:%@" ..
                        "%!%$%&%'%(%)%*%+%,%;%=" .. -- RFC 3986 "sub-delims"
                        "]*$")
  then
    return nil,
           "invalid path: '" .. path ..
           "' (must start with '/' and only contain characters from the " ..
           "reserved list of RFC 3986)"
  end

  -- ensure it is properly percent-encoded
  local raw = resolved:gsub("%%%x%x", "___")
  if raw:find("%", nil, true) then
    local err = raw:sub(raw:find("%%.?.?"))
    return nil, "invalid url-encoded value: '" .. err .. "'"
  end

  return true
end

return {
  name = "url-rewrite",
  fields = {
    { consumer = typedefs.no_consumer, },
    {
      config = {
        type = "record",
        fields = {
          { url = { required = true, type = "string", custom_validator = validate_rewrite_path }, },
          { query_string = { required = false, type = "array", elements = { type = "string" } } },
        }
      }
    }
  }
}
