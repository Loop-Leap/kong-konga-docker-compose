-- kong_plugins/jwt-user-header/handler.lua

local BasePlugin = require "kong.plugins.base_plugin"
local custom_plugin = BasePlugin:extend("jwt-user-header")

custom_plugin.VERSION = "0.1.0"

-- Priority: JWT plugin is 1450. We want to run AFTER it.
-- Setting it lower than JWT ensures JWT processes first in the 'access' phase.
custom_plugin.PRIORITY = 1400

function custom_plugin:new()
  custom_plugin.super.new(self, "jwt-user-header")
end

function custom_plugin:access(conf)
  -- This phase runs after authentication plugins like JWT.
  local authenticated_user = kong.ctx.authenticated_user

  if authenticated_user and authenticated_user.jwt_claims then
    local user_id = authenticated_user.jwt_claims.user_id
    if user_id then
      kong.service.request.set_header("X-Forwarded-UserId", user_id)
      kong.log.debug("jwt-user-header plugin: Set X-Forwarded-UserId to: ", user_id)
    else
      kong.log.warn("jwt-user-header plugin: JWT claims found, but 'user_id' claim is missing.")
    end
  else
    kong.log.warn("jwt-user-header plugin: No authenticated user context or JWT claims found. X-Forwarded-UserId not set.")
  end
end

return custom_plugin