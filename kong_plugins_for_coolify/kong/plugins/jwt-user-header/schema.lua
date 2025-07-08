-- /opt/custom_lua/kong/plugins/jwt-user-header/schema.lua

local typedefs = require "kong.db.schema.typedefs"
-- Remove this line: local PLUGIN_NAME = "jwt-user-header" -- Define plugin name

return {
  name = "jwt-user-header", -- Directly use the string literal for 'name'
  fields = {
    { consumer = typedefs.consumer },
    { service = typedefs.service },
    { route = typedefs.route },
    { protocols = typedefs.protocols_http },
    {
      config = {
        type = "record",
        fields = {
          -- No custom configuration fields needed for this plugin
        },
      },
    },
  },
}