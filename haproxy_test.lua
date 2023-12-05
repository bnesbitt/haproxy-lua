--[[
    An example using the mock API to simulate the HAProxy Lua API.
]]

lu = require('luaunit')
core = require('mock_core')
txn = require('mock_txn')

function test_create_txn()
    -- Initialize core with our default backends.
    core:new()

    local txn = txn:make("GET", "192.168.1.1", "/foo/bar", "https://test.com/foo/bar")
    lu.assertNotIsNil(txn)

    local method = txn:get_var("req.method")
    lu.assertEquals(method, "GET")

    local ip = txn:get_var("req.client_ip")
    lu.assertEquals(ip, "192.168.1.1")
end

os.exit(lu.LuaUnit.run())