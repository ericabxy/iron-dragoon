local ship5fx = require('src.ship5fx')

local ship5 = ship5fx:new{
  arena_width = 256,
  arena_height = 256,
  angle = 0,
  dx = 0,
  dy = 0,
}

function ship5:init()
  love.audio.play(self.sfx_helicopter_loop)
  self.dx = math.cos(self.angle) * 30
  self.dy = math.sin(self.angle) * 30
  return self
end

function ship5:move(dt)
  self.x = (self.x + self.dx * dt)
  self.y = (self.y + self.dy * dt)
  if self.x > self.arena_width - 20 or self.y > self.arena_height - 20 or self.x < -12 or self.y < -12 then
    love.audio.stop(self.sfx_helicopter_loop)
    self.remove_me_from_all_lists = true
  end
  self:animate(dt)
end

function ship5:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return ship5
