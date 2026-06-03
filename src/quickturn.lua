local MAXCOOLDOWN = 1000  -- TODO: Should probably make this configurable (put it in class table).

local quickturn = {
  speed = 16,  -- Default to sixteen radians per second.
  direction = 1,  -- Default to "right" or "clockwise" polarity.
  destination = math.pi,  -- Default to 3.14 radians (180 degrees).
  cooldown = 0,  --
}

function quickturn:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function quickturn:start(destination)
  destination = destination % (2 * math.pi)
  self.destination = destination
  self.cooldown = MAXCOOLDOWN
end

return quickturn
