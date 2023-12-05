# HAProxy Lua mock API

A simple API to mock the Core and Txn Lua API:
https://www.arpalert.org/haproxy-api.html

This helps make is possible to unit test HAProxy Lua scripts by stubbing out the Lua API.

## Example
This mock API can be used with existing Lua unit testing frameworks, for example [LuaUnit](https://github.com/bluebird75/luaunit)

```lua
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
```
