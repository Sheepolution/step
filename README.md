# step

A small timer module that makes it easier to have action execute in a certain interval or after a delay.

## Installation

The step.lua file should be dropped into an existing project and required by it.

```lua
step = require "step"
```

You can then use `step` to create a new timer with `step.new(time)`.

```lua
timer = step.new(3)
```

## Usage

### Interval

Update the timer with `step:update(dt)` or by calling your timer (`timer(dt)`) and pass the delta time as argument. If the timer reaches its set time, it will reset and return true.

```lua
if timer:update(dt) then
    print("This will be printed every 3 seconds.")
end
```

### Delay

You can pass a second argument to `step.new(time, ret)` to prevent the timer from resetting. The passed argument will be returned after the set time has reached. 

```lua
timer = step.new(3, true)
```

```lua
if timer:update(dt) then
    print("After 3 seconds this will be printed every frame.")
end
```

Note that on the first time reaching the timer `true` will always be returned. Only after that will the passed argument returned.

```lua
timer = step.new(3, false)
```

```lua
if timer(dt) then
    print("After 3 seconds this will be printed once.")
end
```

### Reset

You can always reset your timer with `step:reset()` or simply calling your timer without arguments.

```lua
timer:reset()
timer()
```

### Random

If you pass a table with two numbers to `step.new(t)` it will have a random length (with decimals) between those numbers after each reset.

```lua
timer = step.new({3, 5})
```

### Set

You can use `step:set(t, [noreset])` to change the time for this timer. If `noreset` is `true`, the timer will not be reset. 

```lua
timer = step.new(5)
timer:set(3)
```

### Finish

You can use `step:finish()` to set the timer to the end, meaning that on next first update it will return `true` and reset the timer.

```lua
timer = step.new(4.7)
timer:finish()
```

```
if timer(dt) then
    print("On the first frame this will be printed and then again after 4.7 seconds.")    
end
```

## License

This library is free software; you can redistribute it and/or modify it under the terms of the MIT license. See [LICENSE](LICENSE) for details.