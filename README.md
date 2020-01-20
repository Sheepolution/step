# step

A small immediate mode timer module that makes it easier to have an action execute with a certain interval or after a delay.

## Installation

The step.lua file should be dropped into an existing project and required by it.

```lua
step = require "step"
```
You can then use `step` to create a new timer.

## Usage

### Every

You create a new timer with `step.new(time)` or `step.every(time)`. When updated, the timer will return `true` with `time` as the interval.

```lua
timer = step.every(3)
```

#### Update

Update the timer with `timer:update(dt)` or by calling your timer (`timer(dt)`) and pass the delta time as argument.

```lua
if timer:update(dt) then
    print("This will be printed every 3 seconds.")
end
```

### After

If you create a new timer with `step.after()` the timer will return `true` every frame after the timer reaches its set time.

```lua
timer = step.after(3)
```

```lua
if timer:update(dt) then
    print("After 3 seconds this will be printed every frame.")
end
```

### Once

If you create a new timer with `step.once()` the timer will return `true` on the frame the timer reaches its set time. After that it will return false and the timer needs to be manually [reset](#reset).

```lua
timer = step.once(3)
```

```lua
if timer:update(dt) then
    print("After 3 seconds this will be printed once.")
end
```

### During

If you create a new timer with `step.during()` the timer will return `true` on every frame that the timer has not reached its set time. After that it will return false and the timer needs to be manually [reset](#reset).
```lua
timer = step.during(3)
```

```lua
if timer:update(dt) then
    print("This will be printed every frame until 3 seconds have passed")
end
```

### Reset

You can always reset your timer with `timer:reset()` or simply calling your timer without arguments.

```lua
timer:reset()
timer()
```

### Random

If you pass a table with two numbers to `timer.new(t)` it will have a random length (with decimals) between those numbers after each reset.

```lua
timer = step.new({3, 5})
```

### Set

You can use `timer:set(t, [noreset])` to change the time for this timer. If `noreset` is `true`, the timer will not be reset. 

```lua
timer = step.new(5)
timer:set(3)
```

### Finish

You can use `timer:finish()` to set the timer to the end, meaning that on the next update with `step.every` it will return `true` and reset the timer.

```lua
timer = step.new(4.7)
timer:finish()
```

```lua
if timer(dt) then
    print("On the first frame this will be printed and then again after 4.7 seconds.")    
end
```

## License

This library is free software; you can redistribute it and/or modify it under the terms of the MIT license. See [LICENSE](LICENSE) for details.
