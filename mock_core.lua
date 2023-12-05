--[[
    Stubbing the HAProxy Core API:
    https://www.arpalert.org/src/haproxy-lua-api/2.7/#core-class
]]

local mock_concat = require('mock_concat')

-- stub the 'core' global variable that HAProxy creates
local Core = {}

Core.register_action = function()end
Core.register_init = function()end
Core.register_fetches = function()end
Core.register_converters = function()end
Core.register_service = function()end

--[[
    Initializes the core API with some default backends.
    TODO: provide a means to use user-defined backends.
]]
function Core:new()
    local core = {}
    setmetatable(core, Core)
    self.__index = self

    -- Add in some default backends.
    self.backends = {
        {index = "1", name="web"},
        {index = "2", name="mysql"},
        {index = "3", name="aws"},
    }

    self.alert_called = 0

    for _, backend in pairs(self.backends) do
        local backend_name = backend.name

        backend.get_cap = function()
            return "backend"
        end

        Core.Debug("Mock Core: Loading backend: " .. backend_name)
    end

    return core
end

function Core.Debug(s)
    print(s)
end

function Core.Info(s)
    print(s)
end

function Core.Warn(s)
    print(s)
end

function Core.Alert(s)
    Core.alert_called = Core.alert_called + 1
    print(s)
end

function Core.concat()
    return mock_concat:new()
end

return Core
