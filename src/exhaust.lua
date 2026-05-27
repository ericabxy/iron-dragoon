local exhaust2sprite = require('src.exhaust2sprite')

local exhaust = exhaust2sprite:new{
  rocket = { x = 0, y = 0, angle = 0 }
}

function exhaust:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return exhaust
