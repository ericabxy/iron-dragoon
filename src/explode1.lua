--- @module src.explode1
local explode1sprite = require('src.explode1sprite')

-- class table
local explode1 = explode1sprite:new{
  iron_dragoon_type_id = 'explosion',
}

-- Move according to momentum and update graphics
function explode1:move(dt)
  self:animate(dt)
end

function explode1:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return explode1
