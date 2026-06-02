--- This is a graphical upgrade to "pship" with a new sprite and different quads.
-- @module src.iron_plague_pship2
local hitball = require('src.hitball')
local iron_plague_pship = require('src.iron_plague_pship')

local iron_plague_pship2 = iron_plague_pship:new{
  texture = love.graphics.newImage('share/iron_plague_pship2.png'),
  quads = {
    [0] = love.graphics.newQuad(96, 48, 25, 25, 128, 128),
    [1] = love.graphics.newQuad(96, 72, 25, 25, 128, 128),
    [2] = love.graphics.newQuad(96, 96, 25, 25, 128, 128),
    [3] = love.graphics.newQuad(72, 96, 25, 25, 128, 128),
    [4] = love.graphics.newQuad(48, 96, 25, 25, 128, 128),
    [5] = love.graphics.newQuad(24, 96, 25, 25, 128, 128),
    [6] = love.graphics.newQuad(0, 96, 25, 25, 128, 128),
    [7] = love.graphics.newQuad(0, 72, 25, 25, 128, 128),
    [8] = love.graphics.newQuad(0, 48, 25, 25, 128, 128),
    [9] = love.graphics.newQuad(0, 24, 25, 25, 128, 128),
    [10] = love.graphics.newQuad(0, 0, 25, 25, 128, 128),
    [11] = love.graphics.newQuad(24, 0, 25, 25, 128, 128),
    [12] = love.graphics.newQuad(48, 0, 25, 25, 128, 128),
    [13] = love.graphics.newQuad(72, 0, 25, 25, 128, 128),
    [14] = love.graphics.newQuad(96, 0, 25, 25, 128, 128),
    [15] = love.graphics.newQuad(96, 24, 25, 25, 128, 128),
  },
  hitballs = {
    hitball:new{ radius = 4.5 },
    hitball:new{ radius = 5.5 },
    hitball:new{ radius = 6.5 },
  },
}

function iron_plague_pship2:is_touching(o)
  self.hitballs[1].x = self.x - math.cos(self.angle) * 5
  self.hitballs[1].y = self.y - math.sin(self.angle) * 5
  if self.hitballs[1]:is_touching(o) then return true end
  self.hitballs[2].x = self.x
  self.hitballs[2].y = self.y
  if self.hitballs[2]:is_touching(o) then return true end
  self.hitballs[3].x = self.x + math.cos(self.angle) * 5
  self.hitballs[3].y = self.y + math.sin(self.angle) * 5
  if self.hitballs[3]:is_touching(o) then return true end
end

function iron_plague_pship2:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_pship2
