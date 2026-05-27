--- @module src.debris_sprite
local debris_sprite = require('src.debris_sprite')

local LARGE = 2
local MEDIUM = 1
local SMALL = 0

-- class table
local debris = debris_sprite:new{
  size = LARGE,
  dx = 0,
  dy = 0,
}

function debris:init()
  local speed = 20
  local angle = love.math.random() * ( 2 * math.pi )
  self.texture = self.textures[self.size]
  self.dx = math.cos(angle) * speed 
  self.dy = math.sin(angle) * speed
  return self
end

function debris:is_touching(o)
  local hitsize = 5
  if self.x - hitsize < o.x and self.x + hitsize > o.x and self.y - hitsize < o.y and self.y + hitsize > o.y then
    return true
  end
end

-- Move according to momentum and update graphics
function debris:move(dt)
  self.x = (self.x + self.dx * dt) % 256
  self.y = (self.y + self.dy * dt) % 256
  self:animate(dt)
end

function debris:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return debris
