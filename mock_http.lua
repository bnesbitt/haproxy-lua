local mock_http = {}

function mock_http:new()
  local o = {}
  setmetatable(o, mock_http)
  self.__index = self

  o.headers = {}

  return o
end

function mock_http:req_get_header(hdr_name)
  local hdr_value = self.headers[hdr_name]
  return hdr_value
end

function mock_http:req_set_header(hdr_name, hdr_value)
  self.headers[hdr_name] = hdr_value
end

return mock_http
