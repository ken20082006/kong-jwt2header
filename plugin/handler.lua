-- dynamic routing based on JWT Claim

local sub = string.sub
local type = type
local pairs = pairs
local lower = string.lower

local jwt_decoder = require "kong.plugins.jwt.jwt_parser"

local JWT2Header = {
    PRIORITY = 2000,
    VERSION = "1.0"
}

function JWT2Header:access(conf)
    kong.service.request.set_header("X-Kong-JWT-Kong-Proceed", "no")
    kong.log.debug(kong.request.get_header("Authorization"))
    local claims = nil
    local header = nil
    if kong.request.get_header("Authorization") ~= nil then
        kong.log.debug(kong.request.get_header("Authorization"))
        if string.match(lower(kong.request.get_header("Authorization")), 'bearer') ~= nil then
            kong.log.debug("2" .. kong.request.get_path())
            local jwt, err = jwt_decoder:new((sub(kong.request.get_header("Authorization"), 8)))
            if err then
                return false, { status = 401, message = "Bad token; " .. tostring(err) }
            end

            claims = jwt.claims
            header = jwt.header
            kong.service.request.set_header("X-Kong-JWT-Kong-Proceed", "yes")
        end
    end

    if kong.request.get_header("X-Kong-JWT-Kong-Proceed") == "yes" then
        kong.log.debug("try to add claims:" .. table.concat(conf.claims, ","))
        for claim, value in pairs(claims) do
            if type(claim) == "string" and type(value) == "string" and contains(conf.claims, claim) then
                kong.log.debug("adding claim to header:" .. claim .. ":" .. value)
                kong.service.request.set_header("X-Kong-JWT-Claim-" .. claim, value)
            end
        end
    end

end

function contains(arr, target)
   for _, value in ipairs(arr) do
      if value == target then
         return true
      end
   end
   return false
end

return JWT2Header
