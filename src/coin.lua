local remastered_tyrian_coin = require('src.remastered_tyrian_coin')

local coin = remastered_tyrian_coin:new{
  iron_dragoon_type = 'pickup',
  iron_dragoon_pickup_type = 'coin',
  iron_dragoon_coin_type = 'gold',
  screen_width = 256,
  screen_height = 256,
  value = 500,
  radius = 4,
  dx = 0,
  dy = 0,
}

function coin:init()
  local angle = love.math.random() * ( 2 * math.pi )
  self.dx = self.dx + math.cos(angle) * 20
  self.dy = self.dy + math.sin(angle) * 20
  self.texture = self.textures[self.iron_dragoon_coin_type]
  return self
end

function coin:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = self.x % self.screen_width
  self.y = self.y % self.screen_height
  self:animate()
end

function coin:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return coin
