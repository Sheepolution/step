local step = {}
step.__index = step

local function rand(range)
  return range[1] + math.random() * (range[2] - range[1])
end

function step.new(t, manual)
	local range = type(t) == "table" and t or false
	t = range and rand(range) or t
	return setmetatable({
		range = range,
		time = t,
		timer = 0,
		manual = manual,
		paused = false
		}, step)
end

function step:__call(dt)
	if dt then
		return self:update(dt)
	else
		self:reset()
	end
end

function step:update(dt)
	if self.paused then return self.manual end
	self.timer = self.timer + dt
	if self.timer >= self.time then
		self.timer = self.timer - self.time
		if self.range then
			self.time = rand(self.range)
		end
		if self.manual ~= nil then
			self.paused = true
		end
		return true
	end
	return false
end

function step:reset()
	self.paused = false
	self.timer = 0
end

function step:set(t, noreset)
	self.time = t
	self.timer = noreset and self.timer or 0
end

function step:end()
	self.timer = time
end

return step