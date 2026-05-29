local sfx_wpn_laser1 = {
  source = love.audio.newSource('share/sfx_wpn_laser1.wav', 'static'),
  source2 = love.audio.newSource('share/sfx_wpn_laser1.wav', 'static')
}

function sfx_wpn_laser1:on()
  if not self.source:isPlaying() then
    love.audio.play(self.source)
  elseif not self.source2:isPlaying() then
    love.audio.play(self.source2)
  end
end

function sfx_wpn_laser1:off()
  love.audio.stop(self.source)
end

function sfx_wpn_laser1:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return sfx_wpn_laser1
