--- Base class standardizing logic between different gameplay configurations
-- @module src.gamemode
local gamemode = {}

function gamemode:start()
end

function gamemode:run()
end

function gamemode:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return gamemode
