--- @module src.teleport
-- Player ability to "jump" to a random spot on the board.
local MAXCOOLDOWN = 1000  -- TODO: Should probably make this configurable (put it in class table).

local teleport = {
  max_width = 256,
  max_height = 256,
  cooldown = 0,  --
}

function teleport:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return teleport
