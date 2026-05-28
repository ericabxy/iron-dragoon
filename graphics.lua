local background = love.graphics.newImage('share/space.png')
local bitmapfont = require('src.bitmap_font_futuristic')

local graphics = {
  object_to_follow_with_camera = false,
  origin_x = 0,
  origin_y = 0,
  scroll_x = 0,
  scroll_y = 0,
  space_width = 256,
  space_height = 256,
  background_layer = love.graphics.newCanvas(256, 256),
  sprites_layer_0 = {},
  sprites_layer_1 = {},
  sprites_layer_2 = {},
  sprites_layer_3 = {},
  player0 = { hit_points = 64 },
  stage_name = {
    'GAME 01',
    'PHYSICS',
    'DEMO',
  },
}

love.graphics.setCanvas(graphics.background_layer)
love.graphics.draw(background, 0, 0)

function graphics.draw_sprite_layer(o, x, y)
  for i = #o, 1, -1 do
    o[i]:paint(x, y)
    if o[i].remove_me_from_all_lists then table.remove(o, i) end
  end
end

function graphics.flush_sprites()
  graphics.sprites_layer_0 = {}
  graphics.sprites_layer_1 = {}
  graphics.sprites_layer_2 = {}
  graphics.sprites_layer_3 = {}
end

function love.draw()
  love.graphics.setCanvas()
  if graphics.object_to_follow_with_camera then
    graphics.scroll_x = -graphics.object_to_follow_with_camera.x + 128
    graphics.scroll_y = -graphics.object_to_follow_with_camera.y + 128
  end
  love.graphics.draw(graphics.background_layer, graphics.origin_x + graphics.scroll_x, graphics.origin_y + graphics.scroll_y)
  for x = -graphics.space_width, graphics.space_width, graphics.space_width do
    for y = -graphics.space_height, graphics.space_height, graphics.space_height do
      graphics.draw_sprite_layer(graphics.sprites_layer_0, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_1, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_2, x + graphics.scroll_x, y + graphics.scroll_y)
      graphics.draw_sprite_layer(graphics.sprites_layer_3, x + graphics.scroll_x, y + graphics.scroll_y)
    end
  end
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', 256, 0, 64, 240)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', 256, 0, graphics.player0.hit_points, 6)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('line', 256, 0, 63, 5)
  love.graphics.setFont(bitmapfont)
  for n, text in ipairs(graphics.stage_name) do
    love.graphics.print(text, 256, 208 + (n * 8))
  end
end

return graphics
