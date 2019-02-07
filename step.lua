--
-- step
--
-- Copyright (c) 2019 Sheepolution

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local function rand(range)
  return range[1] + math.random() * (range[2] - range[1])
end

local timer = {}
timer.__index = timer

function timer:update(dt)
	if self.finished and self.kind > 1 then
		return self.kind == 2
	end
	self.timer = self.timer + dt
	if self.timer >= self.time then
		self.timer = self.timer - self.time
		self.finished = true
		if self.range then
			self.time = rand(self.range)
		end
		return self.kind ~= 4
	end
	return self.kind == 4
end

function timer:__call(dt)
	if dt then
		return self:update(dt)
	else
		self:reset()
	end
end

function timer:reset()
	self.finished = false
	self.timer = 0
end

function timer:set(t, noreset)
	self.time = t
	self.timer = noreset and self.timer or 0
end

function timer:finish()
	self.finished = false
	self.timer = self.time
end

local step = {}

function step.new(t, kind)
	local range = type(t) == "table" and t or false
	t = range and rand(range) or t
	return setmetatable({
		range = range,
		time = t,
		timer = 0,
		kind = kind or 1,
		finished = false
		}, timer)
end

function step.every(t)
	return step.new(t, 1)
end

function step.after(t)
	return step.new(t, 2)
end

function step.once(t)
	return step.new(t, 3)
end

function step.during(t)
	return step.new(t, 4)
end

return step