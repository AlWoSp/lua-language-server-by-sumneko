local files       = require 'files'
local converter   = require 'proto.converter'
local log         = require 'log'
local pformatting = require 'provider.formatting'


---@async
return function(uri, callback)    local state = files.getState(uri)
    if not state then
        return
    end
    local text = state.originText

    local suc, codeFormat  = pcall(require, 'code_format')
    if not suc then
        return
    end

    pformatting.updateConfig(uri)

    local status, diagnosticInfos = codeFormat.name_style_analysis(uri, text)

    if not status then
        if diagnosticInfos ~= nil then
            log.error(diagnosticInfos)
        end

        return
    end

    if diagnosticInfos then
        for _, diagnosticInfo in ipairs(diagnosticInfos) do
            callback {
                start   = converter.unpackPosition(state, diagnosticInfo.range.start),
                -- end index needs to be increased for correct handling in language server
                finish  = converter.unpackPosition(state, diagnosticInfo.range["end"]) + 1,
                message = diagnosticInfo.message
            }
        end
    end
end
