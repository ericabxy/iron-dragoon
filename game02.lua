--- Functions for loading and running Game 2 of Iron Dragoon.
-- Working title: "Solar Liberator" or "Sector Protector".
local background_texture = love.graphics.newImage('share/space.png')
local graphics = require('graphics')
local programs = require('programs')
local gamemode = require('src.gamemode')

local game02 = gamemode:new{}

local background_layer = love.graphics.newCanvas(1024 + 512, 768 + 512)
love.graphics.setCanvas(background_layer)
love.graphics.draw(background_texture, 0, 0)
for x = -256, 1024 + 256, 256 do
  for y = -256, 768 + 256, 256 do
    love.graphics.draw(background_texture, x, y)
  end
end

function game02.start()
  graphics.flush_sprites()
  programs.flush_objects()
  graphics.origin_x = -256
  graphics.origin_y = -256
  graphics.space_width = 1024
  graphics.space_height = 768
  graphics.background_layer = background_layer
  programs.spawn_sun{ x = 512, y = 384 }
  player0 = programs.spawn_pship{ x = 128, y = 120, space_width = 1024, space_height = 768 }
  graphics.object_to_follow_with_camera = player0
  graphics.player0 = player0
  return player0
end

function game02.run()
end

return game02
