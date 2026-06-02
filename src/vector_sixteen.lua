local cos = { [0] = math.cos(math.rad(0)), math.cos(math.rad(22.5)), math.cos(math.rad(45)), math.cos(math.rad(67.5)), math.cos(math.rad(90)), math.cos(math.rad(112.5)), math.cos(math.rad(135)), math.cos(math.rad(157.5)), math.cos(math.rad(180)), math.cos(math.rad(202.5)), math.cos(math.rad(225)), math.cos(math.rad(247.5)), math.cos(math.rad(270)), math.cos(math.rad(292.5)), math.cos(math.rad(315)), math.cos(math.rad(337.5)) }

local sin = { [0] = math.sin(math.rad(0)), math.sin(math.rad(22.5)), math.sin(math.rad(45)), math.sin(math.rad(67.5)), math.sin(math.rad(90)), math.sin(math.rad(112.5)), math.sin(math.rad(135)), math.sin(math.rad(157.5)), math.sin(math.rad(180)), math.sin(math.rad(202.5)), math.sin(math.rad(225)), math.sin(math.rad(247.5)), math.sin(math.rad(270)), math.sin(math.rad(292.5)), math.sin(math.rad(315)), math.sin(math.rad(337.5)) }

local number_of_cardinal_directions = 16

local vector_sixteen = {
  cardinal_length = (2 * math.pi) / number_of_cardinal_directions,  -- Length of a cardinal arc.
  cardinal_steps = number_of_cardinal_directions,
  fine_angle = 1.5 * math.pi,  -- Default direction is "up".
  angle = 1.5 * math.pi,  -- Default direction is "up".
  cardinal = 12,  -- "Up" is the twelveth cardinal direction.
}

function vector_sixteen:rotate(arc_length)
  self.fine_angle = self.fine_angle + arc_length
  self.fine_angle = self.fine_angle % (2 * math.pi)
  self.cardinal = math.floor(self.cardinal_steps * self.fine_angle / (2 * math.pi) + self.cardinal_steps + 0.5) % self.cardinal_steps
  self.angle = self.cardinal * self.cardinal_length
end

function vector_sixteen:scale(s)
  return cos[self.sector] * s, sin[self.sector] * s
end

function vector_sixteen:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return vector_sixteen
