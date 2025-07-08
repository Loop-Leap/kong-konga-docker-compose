-- kong_plugins/jwt-user-header/schema.lua

local typedefs = require "kong.db.schema.typedefs"

return {
  name = "jwt-user-header",
  fields = {
    { consumer = typedefs.no_consumer },
    { service = typedefs.no_service },
    { route = typedefs.no_route },
    { protocols = typedefs.protocols_http },
    {
      config = {
        type = "record",
        fields = {
          -- No custom configuration fields for this plugin
        },
      },
    },
  },
}