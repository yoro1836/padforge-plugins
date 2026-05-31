return {
  id = "deadzone",
  name = "Deadzone Filter",
  version = "1.0.0",
  author = "padforge",
  description = "Circular deadzone (‰-based per stick)",
  settings = {
    { key = "deadzone_left",  label = "Left (‰)",  kind = "permille", default = "91", min = 0, max = 1000 },
    { key = "deadzone_right", label = "Right (‰)", kind = "permille", default = "91", min = 0, max = 1000 },
  },
  process = function(stick, cfg, pf)
    local dz = tonumber(cfg["deadzone_" .. stick.side]) or 0
    if dz <= 0 then return stick end
    local thr = dz * 32767 / 1000
    if stick.x * stick.x + stick.y * stick.y < thr * thr then
      stick.x = 0; stick.y = 0
    end
    return stick
  end
}
