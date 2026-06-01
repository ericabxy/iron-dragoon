local sprite = require('src.sprite')

local iron_plague_bullet_flame_sixteen_way_fx = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/iron_plague_bullet_flame2_sixteen_way.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(48, 24, 13, 13, 64, 64),
    [1] = love.graphics.newQuad(48, 36, 13, 13, 64, 64),
    [2] = love.graphics.newQuad(48, 48, 13, 13, 64, 64),
    [3] = love.graphics.newQuad(36, 48, 13, 13, 64, 64),
    [4] = love.graphics.newQuad(24, 48, 13, 13, 64, 64),
    [5] = love.graphics.newQuad(12, 48, 13, 13, 64, 64),
    [6] = love.graphics.newQuad(0, 48, 13, 13, 64, 64),
    [7] = love.graphics.newQuad(0, 36, 13, 13, 64, 64),
    [8] = love.graphics.newQuad(0, 24, 13, 13, 64, 64),
    [9] = love.graphics.newQuad(0, 12, 13, 13, 64, 64),
    [10] = love.graphics.newQuad(0, 0, 13, 13, 64, 64),
    [11] = love.graphics.newQuad(12, 0, 13, 13, 64, 64),
    [12] = love.graphics.newQuad(24, 0, 13, 13, 64, 64),
    [13] = love.graphics.newQuad(36, 0, 13, 13, 64, 64),
    [14] = love.graphics.newQuad(48, 0, 13, 13, 64, 64),
    [15] = love.graphics.newQuad(48, 12, 13, 13, 64, 64),
  },
  ox = -7,
  oy = -7,
}

function iron_plague_bullet_flame_sixteen_way_fx:init()
  self.texture = self.textures[0]
  self.quad = self.quads[0]
  return self
end

function iron_plague_bullet_flame_sixteen_way_fx:set_sprite_angle(angle_in_degrees)
  local rotation_frame = math.ceil(angle_in_degrees / 22.5)
  self.quad = self.quads[rotation_frame]
end

function iron_plague_bullet_flame_sixteen_way_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return iron_plague_bullet_flame_sixteen_way_fx
