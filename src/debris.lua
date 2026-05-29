--- @module src.debris_sprite
local debris_sprite = require('src.debris_sprite')
local explode2 = require('src.explode2')
local explosion_sfx = love.audio.newSource('share/sfx_exp_shortest_hard1.wav', 'static')

local LARGE = 2
local MEDIUM = 1
local SMALL = 0

-- class table
local debris = debris_sprite:new{
  iron_dragoon_type = 'debris',
  space_width = 256,
  space_height = 256,
  size = LARGE,
  dx = 0,
  dy = 0,
}

function debris:collide_with_bullet(o)
  if self.remove_me_from_all_lists then return end
  local hitsize = 5
  if self.x - hitsize < o.x and self.x + hitsize > o.x and self.y - hitsize < o.y and self.y + hitsize > o.y then
    love.audio.play(explosion_sfx)
    self.remove_me_from_all_lists = true
    o.remove_me_from_all_lists = true
    if self.size == LARGE then
      return {
        explode2:new{ x = self.x, y = self.y },
        debris:new{ x = self.x, y = self.y, size = MEDIUM }:init(),
        debris:new{ x = self.x, y = self.y, size = MEDIUM }:init()
      }
    elseif self.size == MEDIUM then
      return {
        explode2:new{ x = self.x, y = self.y },
        debris:new{ x = self.x, y = self.y, size = SMALL }:init(),
        debris:new{ x = self.x, y = self.y, size = SMALL }:init()
      }
    elseif self.size == SMALL then
      return {
        explode2:new{ x = self.x, y = self.y }
      }
    end
  end
end

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
  self.x = (self.x + self.dx * dt) % self.space_width
  self.y = (self.y + self.dy * dt) % self.space_height
  self:animate(dt)
end

function debris:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return debris
