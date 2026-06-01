local constants = require('src.constants')
local starship_picket = require('src.starship_picket')
local starship_scout = require('src.starship_scout')
local graphics = require('graphics')
local programs = require('programs')
local game01 = require('game01')
local game02 = require('game02')

local globalcooldown = 0
local players_t = {}
local bullets_t = {}
local debris_t = {}
local player0 = starship_scout:new{ x = 128, y = 128, controller_number = 1 }
local current_game = game01

function love.load()
  table.insert(graphics.sprites_layer_2, player0)
  table.insert(players_t, player0)
end

function love.update(dt)
  player0:control(dt)
  player0:move(dt)
  for i = #bullets_t, 1, -1 do
    local this_bullet = bullets_t[i]
    this_bullet:move(dt)
    if this_bullet.remove_me_from_all_lists then table.remove(bullets_t, i) end
  end
  programs.advance_physics(dt)
  current_game.run(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'return' then
    love.load()
  elseif key == '1' then
    current_game = game01
    player0 = current_game.start()
  elseif key == '2' then
    current_game = game02
    player0 = current_game.start()
  end
end
