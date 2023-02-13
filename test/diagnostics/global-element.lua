local config = require 'config'
local util   = require 'utility'

 -- disable all default groups to make isolated tests
config.get(nil, 'Lua.diagnostics.groupFileStatus')['ambiguity']     = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['await']         = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['codestyle']     = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['duplicate']     = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['global']        = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['luadoc']        = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['redefined']     = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['strict']        = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['strong']        = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['type-check']    = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['unbalanced']    = 'None'
config.get(nil, 'Lua.diagnostics.groupFileStatus')['unused']        = 'None' 

-- disable all default groups to make isolated tests
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['ambiguity']     = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['await']         = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['codestyle']     = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['duplicate']     = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['global']        = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['luadoc']        = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['redefined']     = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['strict']        = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['strong']        = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['type-check']    = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['unbalanced']    = 'None'})
config.set(nil, 'Lua.diagnostics.groupFileStatus', {['unused']        = 'None'})

-- have to enable global-element diagnostics
config.set(nil, 'Lua.diagnostics.groupFileStatus', {["conventions"] = "Any"})

-- check that local elements are not warned about
TEST [[
---@diagnostic disable:unused-local
---@diagnostic disable:lowercase-global

---@diagnostic enable:global-element

local x = 123
<!Y!> = "global"
<!z!> = "global"
]]

    --<!Y!> = "global"
    --<!z!> = "global"
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