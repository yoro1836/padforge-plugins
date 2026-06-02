return {
  id = "deadzone",
  name = "Deadzone Filter",
  version = "1.0.0",
  author = "keyforge",
  description = "Circular deadzone (‰-based per stick)",
  settings = {
    { key = "deadzone_left",  label = "Left (‰)",  kind = "permille", default = "91", min = 0, max = 1000 },
    { key = "deadzone_right", label = "Right (‰)", kind = "permille", default = "91", min = 0, max = 1000 },
  },
  process = function(ev, cfg, pf)
    if ev.kind ~= "stick" then return ev end
    local dz = tonumber(cfg["deadzone_" .. ev.side]) or 0
    if dz <= 0 then return ev end
    local thr = dz * 32767 / 1000
    if ev.x * ev.x + ev.y * ev.y < thr * thr then
      ev.x = 0; ev.y = 0
    end
    return ev
  end
}
