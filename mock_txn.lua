--[[
    Stubbing the HAProxy txn class.
    https://www.arpalert.org/src/haproxy-lua-api/2.7/#txn-class
]]

local mock_http = require('mock_http')

local Txn = {}

function Txn:create()
    local txn = {}

    self.__index = self
    setmetatable(txn, Txn)

    txn.vars = {}
    txn:set_var("req.method", nil)
    txn:set_var("req.client_ip", nil)
    txn:set_var("req.path", nil)
    txn:set_var("req.url", nil)

    -- Mock the http functions.
    local http = mock_http:new()
    txn.http = http

    return txn
end

function Txn:make(method, client_ip, path, url)
    local txn = Txn:create()

    txn:set_var("req.method", method)
    txn:set_var("req.client_ip", client_ip)
    txn:set_var("req.path", path)
    txn:set_var("req.url", url)

    return txn
end

function Txn:Debug(s)
    print("[Debug] " .. s)
end

function Txn:Info(s)
    print("[Info] " .. s)
end

function Txn:Warning(s)
    print("[Warning] " .. s)
end

function Txn:Alert(s)
    print("[Alert] " .. s)
end

function Txn:get_var(name)
    local value = self.vars[name]
    return value
end

function Txn:set_var(name, value)
    self.vars[name] = value
end

return Txn
