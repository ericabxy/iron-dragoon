--- @module src.explode2
local explode2sprite = require('src.explode2sprite')

-- class table
local explode2 = explode2sprite:new{
  iron_dragoon_type = 'explosion',
}

-- Move according to momentum and update graphics
function explode2:move(dt)
  self:animate(dt)
end

function explode2:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return explode2
