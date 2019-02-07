local step = {}
step.__index = step

local function rand(range)
  return range[1] + math.random() * (range[2] - range[1])
end

local function update(self, dt)
	self.timer = self.timer + dt
	if self.timer >= self.time then
		self.timer = self.timer - self.time
		self.finished = true
		if self.range then
			self.time = rand(self.range)
		end
		return true
	end
	return false
end

function step.new(t)
	local range = type(t) == "table" and t or false
	t = range and rand(range) or t
	return setmetatable({
		range = range,
		time = t,
		timer = 0,
		finished = false
		}, step)
end

function step:__call(dt)
	if dt then
		return self:every(dt)
	else
		self:reset()
	end
end

function step:every(dt)
	self.finished = false
	return update(self, dt)
end

function step:after(dt)
	if self.finished then return true end
	return update(self, dt)
end

function step:once(dt)
	if self.finished then return false end
	return update(self, dt)
end

function step:during(dt)
	if not self.finished then
		return not update(self, dt)
	end
	return false
end

function step:reset()
	self.finished = false
	self.timer = 0
end

function step:set(t, noreset)
	self.time = t
	self.timer = noreset and self.timer or 0
end

function step:finish()
	self.finished = false
	self.timer = self.time
end

return step
