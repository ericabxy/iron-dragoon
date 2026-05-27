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

return game01
