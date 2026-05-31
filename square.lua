return {
  id = "square",
  name = "Square Correction",
  version = "1.0.0",
  author = "padforge",
  description = "Circular to square stick mapping",
  settings = {
    { key = "square_enabled", label = "Enabled", kind = "toggle", default = "1" },
  },
  process = function(stick, cfg)
    if cfg.square_enabled ~= "1" then return stick end
    if stick.x == 0 and stick.y == 0 then return stick end
    local limit = 31500.0
    local scale = 32767.0 / limit
    local dx = math.max(-limit, math.min(limit, stick.x))
    local dy = math.max(-limit, math.min(limit, stick.y))
    local mag = math.sqrt(dx * dx + dy * dy)
    local max_a = math.max(math.abs(dx), math.abs(dy))
    if max_a == 0 then return stick end
    local f = (mag / max_a) * scale
    stick.x = math.floor(math.max(-32767, math.min(32767, dx * f + 0.5)))
    stick.y = math.floor(math.max(-32767, math.min(32767, dy * f + 0.5)))
    return stick
  end
}
