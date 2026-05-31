return {
  id = "outer_deadzone",
  name = "Outer Deadzone",
  version = "1.0.0",
  author = "padforge",
  description = "Saturates stick near edges — small pushes reach full output",
  settings = {
    { key = "outer_dz_left",  label = "Left outer (‰)",  kind = "permille", default = "0", min = 0, max = 500 },
    { key = "outer_dz_right", label = "Right outer (‰)", kind = "permille", default = "0", min = 0, max = 500 },
  },
  process = function(stick, cfg, pf)
    local outer = tonumber(cfg["outer_dz_" .. stick.side]) or 0
    if outer <= 0 then return stick end
    local limit = (1000 - outer) * 32767 / 1000
    if stick.x > limit then stick.x = 32767
    elseif stick.x < -limit then stick.x = -32767 end
    if stick.y > limit then stick.y = 32767
    elseif stick.y < -limit then stick.y = -32767 end
    return stick
  end
}
