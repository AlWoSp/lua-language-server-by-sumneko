local files   = require 'files'
local lang    = require 'language'
local guide   = require "parser.guide"
local await   = require 'await'

local function findParam(docs, param)
    for _, doc in ipairs(docs) do
        if doc.type == 'doc.param' then
            if doc.param[1] == param then
                return true
            end
        end
    end

    return false
end


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

        if not source.args then
            return
        end

        if source.bindDocs then
            for _, arg in ipairs(source.args) do
                local name = arg[1]
                if name ~= 'self' then
                    if not findParam(source.bindDocs, name) then
                        callback {
                            start   = arg.start,
                            finish  = arg.finish,
                            message = lang.script('DIAG_MISSING_PARAM_DOC', name),
                        }
                    end
                end
            end
        end
    end)
end
