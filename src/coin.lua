local remastered_tyrian_coin = require('src.remastered_tyrian_coin')

local coin = remastered_tyrian_coin:new{
  iron_dragoon_type = 'pickup',
  iron_dragoon_pickup_type = 'gold',
  iron_dragoon_coin_value = 500,
  despawn_timer = 1000,
  screen_width = 256,
  screen_height = 256,
  value = 500,
  radius = 4,
  dx = 0,
  dy = 0,
}

function coin:init()
  local angle = love.math.random() * (math.pi / 2)
  angle = angle + (math.pi / 4)
  self.x = love.math.random(0, 256)
  self.y = 245  -- Spawn just barely offscreen
  self.dx = self.dx + math.cos(angle) * 25
  self.dy = self.dy + math.sin(angle) * 25
  self.despawn_timer = 260 / self.dy
  self.texture = self.textures[self.iron_dragoon_pickup_type]
  return self
end

function coin:move(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  self.x = self.x % self.screen_width
  self.y = self.y % self.screen_height
  self:animate()
  self.despawn_timer = self.despawn_timer - dt
  if self.despawn_timer <= 0 then self.remove_me_from_all_lists = true end
end

function coin:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return coin
