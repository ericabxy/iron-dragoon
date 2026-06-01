local sprite = require('src.sprite')

local m484_bullet_collection_2_sixteen_way_fx = sprite:new{
  textures = {
    [0] = love.graphics.newImage('share/m484_bullet_collection_2_sixteen_way.png'),
  },
  quads = {
    [0] = love.graphics.newQuad(50, 26, 13, 13, 64, 64),
    [1] = love.graphics.newQuad(50, 37, 13, 13, 64, 64),
    [2] = love.graphics.newQuad(50, 50, 13, 13, 64, 64),
    [3] = love.graphics.newQuad(37, 50, 13, 13, 64, 64),
    [4] = love.graphics.newQuad(26, 49, 13, 13, 64, 64),
    [5] = love.graphics.newQuad(14, 50, 13, 13, 64, 64),
    [6] = love.graphics.newQuad(1, 50, 13, 13, 64, 64),
    [7] = love.graphics.newQuad(1, 37, 13, 13, 64, 64),
    [8] = love.graphics.newQuad(1, 26, 13, 13, 64, 64),
    [9] = love.graphics.newQuad(1, 15, 13, 13, 64, 64),
    [10] = love.graphics.newQuad(1, 1, 13, 13, 64, 64),
    [11] = love.graphics.newQuad(14, 2, 13, 13, 64, 64),
    [12] = love.graphics.newQuad(26, 2, 13, 13, 64, 64),
    [13] = love.graphics.newQuad(37, 1, 13, 13, 64, 64),
    [14] = love.graphics.newQuad(49, 2, 13, 13, 64, 64),
    [15] = love.graphics.newQuad(48, 12, 13, 13, 64, 64),
  },
  ox = -7,
  oy = -7,
}

function m484_bullet_collection_2_sixteen_way_fx:init()
  self.texture = self.textures[0]
  self.quad = self.quads[0]
  return self
end

function m484_bullet_collection_2_sixteen_way_fx:set_sprite_angle(angle)
  local segment = (2 * math.pi) / 16
  self.quad = self.quads(math.floor( angle / segment ))
end

function m484_bullet_collection_2_sixteen_way_fx:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o:init()
end

return m484_bullet_collection_2_sixteen_way_fx
