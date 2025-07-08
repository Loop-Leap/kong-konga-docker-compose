-- /opt/custom_lua/kong/plugins/jwt-user-header/schema.lua

local typedefs = require "kong.db.schema.typedefs"
local PLUGIN_NAME = "jwt-user-header" -- Define plugin name

return {
  name = PLUGIN_NAME,
  fields = {
    -- Allow this plugin to be associated with a consumer, service, or route
    -- without requiring a configuration field for them.
    -- This makes it a standard attachable plugin.
    { consumer = typedefs.consumer }, -- Can be applied per consumer
    { service = typedefs.service },   -- Can be applied per service
    { route = typedefs.route },       -- Can be applied per route
    { protocols = typedefs.protocols_http }, -- Can run on HTTP/HTTPS
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