local sprite = require('src.exhaust2sprite')

local rocket_engine = sprite:new{
}

function rocket_engine:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return rocket_engine
