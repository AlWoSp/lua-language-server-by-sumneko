local files   = require 'files'
local lang    = require 'language'
local guide   = require "parser.guide"
local await   = require 'await'

local function findReturn(docs, index)
    if not docs then
        return false
    end

    for _, doc in ipairs(docs) do
        if doc.type == 'doc.return' then
            for _, ret in ipairs(doc.returns) do
                if ret.returnIndex == index then
                    return true
                end
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

        if source.parent.type ~= 'setglobal' then
            return
        end

        if not source.returns then
            return
        end

        for _, ret in ipairs(source.returns) do
            for index, expr in ipairs(ret) do
                if not findReturn(source.bindDocs, index) then
                    callback {
                        start   = expr.start,
                        finish  = expr.finish,
                        message = lang.script('DIAG_MISSING_RETURN_DOC'),
                    }
                end
            end
        end
    end)
end
