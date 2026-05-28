local graphics = require('graphics')
local programs = require('programs')

local game01 = {}

function game01.start()
  graphics.flush_sprites()
  programs.flush_objects()
  programs.players_t = {}
  programs.bullets_t = {}
  programs.debris_t = {}
  player0 = programs.spawn_pship{ x = 128, y = 120 }
  graphics.player0 = player0
  return player0
end

function game01.run(dt)
  -- periodically spawn new debris
  if #programs.debris_t < 3 and love.math.random(100) == 1 then
    programs.spawn_debris{ x = love.math.random(256), y = love.math.random(245, 250), size = 2 }
  end
end

return game01
