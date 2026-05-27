local vehicle_plainloop = {
  source = love.audio.newSource('share/sfx_vehicle_plainloop.wav', 'static'),
}

vehicle_plainloop.source:setLooping(true)

function vehicle_plainloop:on()
  if not self.source:isPlaying() then
    love.audio.play(self.source)
  end
end

function vehicle_plainloop:off()
  love.audio.stop(self.source)
end

function vehicle_plainloop:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return vehicle_plainloop
