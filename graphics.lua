local background = love.graphics.newImage('share/space.png')
local bitmapfont = require('src.bitmap_font_futuristic')

local graphics = {
  sprites_layer_0 = {},
  sprites_layer_1 = {},
  sprites_layer_2 = {},
  player0 = { hit_points = 64 },
  stage_name = {
    'GAME 01',
    'PHYSICS',
    'DEMO',
  },
}

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
end

function love.draw()
  love.graphics.draw(background, 0, 0)
  for x = -256, 256, 256 do
    for y = -256, 256, 256 do
      graphics.draw_sprite_layer(graphics.sprites_layer_0, x, y)
      graphics.draw_sprite_layer(graphics.sprites_layer_1, x, y)
      graphics.draw_sprite_layer(graphics.sprites_layer_2, x, y)
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
