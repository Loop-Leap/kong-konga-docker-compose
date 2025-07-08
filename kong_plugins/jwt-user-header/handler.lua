local BasePlugin = require "kong.plugins.base_plugin"
local PLUGIN_NAME = "jwt-user-header" -- Define plugin name

local custom_plugin = BasePlugin:extend(PLUGIN_NAME)

custom_plugin.VERSION = "0.1.0"

-- Define the plugin's priority.
-- JWT plugin's static priority is 1450.
-- We want this plugin to run *after* JWT in the 'access' phase.
-- A priority slightly lower than JWT (e.g., 1400) should work.
custom_plugin.PRIORITY = 1400

function custom_plugin:new()
  custom_plugin.super.new(self, PLUGIN_NAME)
end

-- The 'access' phase is where authentication has happened.
function custom_plugin:access(conf)
  -- Access the authenticated user context.
  -- This should be populated by the JWT plugin.
  local authenticated_user = kong.ctx.authenticated_user

  if authenticated_user and authenticated_user.jwt_claims then
    local user_id = authenticated_user.jwt_claims.user_id
    if user_id then
      kong.service.request.set_header("X-Forwarded-UserId", user_id)
      kong.log.debug(PLUGIN_NAME .. " plugin: Set X-Forwarded-UserId to: ", user_id)
    else
      kong.log.warn(PLUGIN_NAME .. " plugin: JWT claims found, but 'user_id' claim is missing.")
    end
  else
    kong.log.warn(PLUGIN_NAME .. " plugin: No authenticated user context or JWT claims found. X-Forwarded-UserId not set.")
  end
end

return custom_plugin