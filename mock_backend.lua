--[[
    Stubbing the HAProxy backend Lua API.
]]

local mock_backend = {}

function mock_backend:create(name, cap)
    local be = {}

    self.__index = self
    be.name = name
    be.cap = cap

    setmetatable(be, mock_backend)
    return be
end

function mock_backend:get_cap()
    return self.cap
end

function mock_backend:get_name()
    return self.name
end

return mock_backend
