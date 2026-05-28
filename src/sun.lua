local sunsprite = require('src.sunsprite')

local sun = sunsprite:new{}

function sun:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return sunsprite
