local graphics = require('graphics')
local bullet = require('src.bullet')
local debris = require('src.debris')
local explode1 = require('src.explode1')
local explode2 = require('src.explode2')

-- functions to handle game logic
local programs = {
  debris_t = {},
  enemies_t = {},
}

local bullets_t = {}
local explodes_t = {}
local pships_t = {}
local tractors_t = {}
local all_objects_table = {}

function programs.flush_objects()
  bullets_t = {}
  programs.debris_t = {}
  explodes_t = {}
  pships_t = {}
  tractors_t = {}
end

-- Restore all data to initial values.
function programs.reset()
  programs.flush_objects()
  graphics.flush_sprites()
end

function programs.start(stage_number)
  local number_of_debris = 4 + math.floor(stage_number / 5)
  print('Stage ' .. stage_number)
  print('Number of Debris: ' .. number_of_debris)
  for _ = 1, number_of_debris do
    programs.add_object_to_all_tables(
      debris:new{ x = love.math.random(259, 261), y = love.math.random(0, 240) }
    )
  end
  graphics.current_stage_number = stage_number
end

function programs.add_object_to_all_tables(o)
  if o.iron_dragoon_type == 'bullet' then
    table.insert(bullets_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_3, o)
  elseif o.iron_dragoon_type == 'debris' then
    table.insert(programs.debris_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_2, o)
  elseif o.iron_dragoon_type == 'explosion' then
    table.insert(explodes_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_3, o)          
  elseif o.iron_dragoon_type == 'pickup' then
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_2, o)          
  elseif o.iron_dragoon_type == 'playership' then
    table.insert(pships_t, o)
    table.insert(all_objects_table, o)
    table.insert(graphics.sprites_layer_1, o)          
  end
end

function check_for_collision_with_bullets(obj)
  local spawns = {}
  for i = #bullets_t, 1, -1 do
    local this_bullet = bullets_t[i]
    if obj:is_touching_bullet(this_bullet) then
      graphics.current_score = graphics.current_score + obj.value
      local newobj_t = obj:destroy()
      if type(newobj_t) == 'table' then
        for _, newobj in ipairs(newobj_t) do
          table.insert(spawns, newobj)
        end
      end
      this_bullet.remove_me_from_all_lists = true
    end
    if this_bullet.remove_me_from_all_lists then table.remove(bullets_t, i) end
  end
  return spawns
end

function programs.update(dt)
  local list_of_newly_spawned_objects = {}
  for a = #all_objects_table, 1, -1 do
    local obj_a = all_objects_table[a]
    obj_a:move(dt)
    if obj_a.iron_dragoon_type == 'debris' then
      local spawns = check_for_collision_with_bullets(obj_a) or {}
      for _, obj in ipairs(spawns) do
        table.insert(list_of_newly_spawned_objects, obj)
      end
    end
    if obj_a.remove_me_from_all_lists then table.remove(all_objects_table, a) end
  end
  for _, new_object in ipairs(list_of_newly_spawned_objects) do
    programs.add_object_to_all_tables(new_object)
  end
  for x = #programs.debris_t, 1, -1 do
    if programs.debris_t[x].remove_me_from_all_lists then table.remove(programs.debris_t, x) end
  end
end

return programs
