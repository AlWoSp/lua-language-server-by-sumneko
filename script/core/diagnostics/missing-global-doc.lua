local files   = require 'files'
local lang    = require 'language'
local guide   = require "parser.guide"
local await   = require 'await'

---@async
return function (uri, callback)
    local state = files.getState(uri)
    if not state then
        return
    end

    if not state.ast then
        return
    end

    ---@async
    guide.eachSourceType(state.ast, 'function', function (source)
        await.delay()

        if (not source.bindDocs) and (source.parent.type == 'setglobal') then
            local name = source.parent[1]
            if name == nil then
                name = 'anonymous'
            end
            callback {
                start   = source.start,
                finish  = source.finish,
                message = lang.script('DIAG_MISSING_GLOBAL_DOC', name),
            }
        end
    end)
end
