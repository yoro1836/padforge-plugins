return {
  id = "deadzone",
  name = "Deadzone Filter",
  version = "1.0.0",
  author = "padforge",
  description = "Circular deadzone for analog sticks",
  settings = {
    { key = "deadzone_left",  label = "Left Deadzone (‰)",  kind = "permille", default = "91", min = 0, max = 1000 },
    { key = "deadzone_right", label = "Right Deadzone (‰)", kind = "permille", default = "91", min = 0, max = 1000 },
  },
  process = function(stick, cfg)
    local dz = tonumber(cfg["deadzone_" .. stick.side]) or 0
    if dz <= 0 then return stick end
    local threshold = dz * 32767 / 1000
    local mag = stick.x * stick.x + stick.y * stick.y
    if mag < threshold * threshold then
      stick.x = 0
      stick.y = 0
    end
    return stick
  end
}
