local constants = require('src.constants')
local bullet = require('src.bullet')
local debris = require('src.debris')
local pickup_metal = require('src.pickup_metal')
local player_ship = require('src.player_ship')
local graphics = require('graphics')
local programs = require('programs')

local players_t = {}
local player0 = player_ship:new{ x = 128, y = 128, controller_number = 1 }
local current_board = 1

function love.load()
  graphics.sprites_layer_0 = {}
  graphics.sprites_layer_1 = {}
  graphics.sprites_layer_2 = {}
  graphics.sprites_layer_3 = {}
  bullets_t = {}
  debris_t = {}
  players_t = {}
  programs.reset()
  programs.start(1)
  table.insert(players_t, player0)
  programs.add_object_to_all_tables(player0)
end

function love.update(dt)
  local spawns = player0:control(dt) or {}
  for _, o in ipairs(spawns) do
    programs.add_object_to_all_tables(o)
  end
  programs.update(dt)
  if #programs.debris_t <= 0 then
    current_board = current_board + 1
    programs.start(current_board)
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'return' then
    love.load()
  elseif key == '1' then
  elseif key == '2' then
  end
end
