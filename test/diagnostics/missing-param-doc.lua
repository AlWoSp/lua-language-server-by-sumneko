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
    ['missing-param-doc'] = 'Any!' -- override groupFileStatus
})

-- check that local elements are not warned about
TEST [[
local function f1(n)
    print(n)
end

function F2()
end

function F3(<!n!>)
    print(n)
end

---@param n number
function F4(n, <!o!>)
    print(n)
    print(o)
end

f1(1)
]]

TEST [[

]]

TEST [[

]]

-- reset configurations
config.set(nil, 'Lua.diagnostics.groupFileStatus', 
{})
config.set(nil, 'Lua.diagnostics.neededFileStatus',
{})
config.set(nil, 'Lua.diagnostics.globals',
{})