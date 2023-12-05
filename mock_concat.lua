--[[
    Mocking the HAProxy core.concat Lua API:
    https://www.arpalert.org/src/haproxy-lua-api/2.7/#concat-class
]]

local concat = {}

function concat:new()
    local c = {}
    setmetatable(c, concat)
    self.__index = self
    c.str = ""
    return c
end

function concat:add(str)
    self.str = self.str .. str
end

function concat:dump()
    return self.str
end

return concat
