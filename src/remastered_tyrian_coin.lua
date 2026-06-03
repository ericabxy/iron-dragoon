local sprite = require('src.sprite')

local remastered_tyrian_coin = sprite:new{
  textures = {
    gold = love.graphics.newImage('share/remastered_tyrian_coin_gold.png'),
    steel = love.graphics.newImage('share/remastered_tyrian_coin_steel.png'),
    bronze = love.graphics.newImage('share/remastered_tyrian_coin_bronze.png'),
    copper = love.graphics.newImage('share/remastered_tyrian_coin_copper.png'),
  },
  quads = {
    love.graphics.newQuad(0, 0, 13, 13, 128, 16),
    love.graphics.newQuad(12, 0, 13, 13, 128, 16),
    love.graphics.newQuad(24, 0, 13, 13, 128, 16),
    love.graphics.newQuad(36, 0, 13, 13, 128, 16),
    love.graphics.newQuad(48, 0, 13, 13, 128, 16),
    love.graphics.newQuad(60, 0, 13, 13, 128, 16),
  },
  ox = -7,
  oy = -7,
}

remastered_tyrian_coin.texture = remastered_tyrian_coin.textures.gold
remastered_tyrian_coin.quad = remastered_tyrian_coin.quads[1]

function remastered_tyrian_coin:animate()
  local frame = math.floor(love.timer.getTime() * 15) % 6
  self.quad = self.quads[frame + 1]
end

function remastered_tyrian_coin:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return remastered_tyrian_coin
