local remastered_tyrian_coin = require('src.remastered_tyrian_coin')

local pickup_metal = remastered_tyrian_coin:new{
  iron_dragoon_type = 'pickup',
  iron_dragoon_pickup_type = 'gold',
  screen_width = 260,
  screen_height = 240,
  dx = 0,
  dy = 0,
}

function pickup_metal:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = self.x % self.screen_width
  self.y = self.y % self.screen_height
  self:animate()
end

function pickup_metal:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return pickup_metal
