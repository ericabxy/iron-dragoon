--- @module src.coinbank
-- Player ability to collect and store "coins" from the aether.
local coinbank = {
  total = 0,  -- Start with zero coins.
}

function coinbank:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  -- Initialization.
  o.sfx_coin = love.audio.newSource('share/sfx_coin_cluster7.wav', 'static')
  return o
end

function coinbank:collect(o)
  if not o.value then return end
  if not self.sfx_coin:isPlaying() then love.audio.play(self.sfx_coin) end
  self.total = self.total + o.value
  o.remove_me_from_all_lists = true
end

return coinbank
