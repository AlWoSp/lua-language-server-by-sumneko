local config = require 'config'
local util   = require 'utility'

local disables = config.get(nil, 'Lua.diagnostics.groupFileStatus')

-- disable all default groups to make isolated tests
config.set(nil, 'Lua.diagnostics.groupFileStatus', 
{
    ['ambiguity']     = 'None',
    ['await']         = 'None',
    ['codestyle']     = 'None',
    ['conventions']   = 'None',
    ['duplicate']     = 'None',
    ['global']        = 'None',
    ['luadoc']        = 'None',
    ['redefined']     = 'None',
    ['strict']        = 'None',
    ['strong']        = 'None',
    ['type-check']    = 'None',
    ['unbalanced']    = 'None',
    ['unused']        = 'None'
})

-- enable single diagnostic that is to be tested
config.set(nil, 'Lua.diagnostics.neededFileStatus',
{
    ['global-element'] = 'Any!' -- override groupFileStatus
})

-- check that local elements are not warned about
TEST [[
local x = 123
x = 321
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
config.set(nil, 'Lua.diagnostics.globals',
{
    'GLOBAL1',
    'GLOBAL2'
})

TEST [[
    -- variables
    GLOBAL1 = "allowed"
    <!GLOBAL3!> = "not allowed"
]]

TEST [[
    -- functions
]]

TEST [[
    -- closures
]]