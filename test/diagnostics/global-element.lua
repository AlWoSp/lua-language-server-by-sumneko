local config = require 'config'
local util   = require 'utility'

local disables = config.get(nil, 'Lua.diagnostics.disable')
-- have to enable global-element diagnostics


-- check that local elements are warned about
TEST [[
    local x = "local"
    x = "still local"
    <!Y!> = "global"
    <!z!> = "global"
]]

TEST [[
    -- functions
]]

TEST [[
    -- closures
]]




-- add elements to exemption list
TEST [[
    -- variables
]]

TEST [[
    -- functions
]]

TEST [[
    -- closures
]]