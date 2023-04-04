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
    ['missing-return-doc'] = 'Any!', -- override groupFileStatus
    ['redundant-return-value'] = 'None'
})

-- check that local elements are not warned about
TEST [[
local function f1()
    return 1
end

function F2()
end

function F3()
    return <!1!>
end

---@return integer
function F4()
    return 1, <!2!>
end

print(f1())
]]

-- reset configurations
config.set(nil, 'Lua.diagnostics.groupFileStatus', 
{})
config.set(nil, 'Lua.diagnostics.neededFileStatus',
{})
config.set(nil, 'Lua.diagnostics.globals',
{})