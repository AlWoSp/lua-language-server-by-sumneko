local config = require 'config'
local util   = require 'utility'

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
    ['namestyle-check'] = 'Any!' -- override groupFileStatus
})

-- check that namestyle-check is executed
TEST [[
local <!NAME!> = "test"
]]

-- reset configurations
config.set(nil, 'Lua.diagnostics.groupFileStatus', 
{})
config.set(nil, 'Lua.diagnostics.neededFileStatus',
{})
