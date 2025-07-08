local typedefs = require "kong.db.schema.typedefs"
local PLUGIN_NAME = "jwt-user-header" -- Define plugin name

return {
  name = PLUGIN_NAME,
  fields = {
    { consumer = typedefs.no_consumer }, -- This plugin can be applied to consumers
    { service = typedefs.no_service },   -- This plugin can be applied to services
    { route = typedefs.no_route },       -- This plugin can be applied to routes
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