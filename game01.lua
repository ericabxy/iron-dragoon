--- Functions for loading and running Game 1 of Iron Dragoon.
-- Working title: "Meteor Shower".
local graphics = require('graphics')
local programs = require('programs')

local game01 = {
  hurry_up_count = 0,
  stage = 1
}

function game01.spawn_stage(n)
  for _ = 1, math.min(n + 2, 10) do
    programs.spawn_debris{ x = love.math.random(160, 320), y = love.math.random(160, 320), size = 2 }
  end
end

function game01.start()
  graphics.flush_sprites()
  programs.flush_objects()
  game01.stage = 1
  game01.spawn_stage(game01.stage)
  player0 = programs.spawn_pship{ x = 128, y = 120 }
  graphics.player0 = player0
  return player0
end

function game01.run(dt)
  if #programs.debris_t == 0 then
    game01.stage = game01.stage + 1
    game01.spawn_stage(game01.stage)
  end
  game01.hurry_up_count = game01.hurry_up_count + dt * 1000
  if game01.hurry_up_count > 15000 then
    game01.hurry_up_count = 0
    --programs.spawn_ship_5{ x = -12, y = 40, angle = math.rad(love.math.random( 315, 405 )) }
  end
end

return game01
