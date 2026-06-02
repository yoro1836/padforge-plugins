return {
  id = "square",
  name = "Square Correction",
  version = "1.0.0",
  author = "keyforge",
  description = "Circular to square stick mapping per stick",
  settings = {
    { key = "square_left",  label = "Left",  kind = "toggle", default = "1" },
    { key = "square_right", label = "Right", kind = "toggle", default = "1" },
  },
  process = function(ev, cfg, pf)
    if ev.kind ~= "stick" then return ev end
    if cfg["square_" .. ev.side] ~= "1" then return ev end
    if ev.x == 0 and ev.y == 0 then return ev end
    local limit = 31500.0
    local scale = 32767.0 / limit
    local dx = math.max(-limit, math.min(limit, ev.x))
    local dy = math.max(-limit, math.min(limit, ev.y))
    local mag = math.sqrt(dx * dx + dy * dy)
    local max_a = math.max(math.abs(dx), math.abs(dy))
    if max_a == 0 then return ev end
    local f = (mag / max_a) * scale
    ev.x = math.floor(math.max(-32767, math.min(32767, dx * f + 0.5)))
    ev.y = math.floor(math.max(-32767, math.min(32767, dy * f + 0.5)))
    return ev
  end,
  init = function(cfg, pf)
    local devices = pf.scan_devices()
    for _, d in ipairs(devices) do
      local n = d[1]:lower()
      if n:match("xbox") or n:match("pad") or n:match("gamepad")
         or n:match("dualshock") or n:match("controller") then
        pf.set_config("VID", d[2]); pf.set_config("PID", d[3])
        return
      end
    end
  end
}
