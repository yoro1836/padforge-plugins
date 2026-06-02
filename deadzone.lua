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
  end,
  init = function(cfg, pf)
    local devices = pf.scan_devices()
    for _, d in ipairs(devices) do
      local n = d[1]:lower()
      if n:match("xbox") or n:match("pad") or n:match("gamepad")
         or n:match("dualshock") or n:match("controller") then
        pf.set_config("VID", d[2]); pf.set_config("PID", d[3])
        pf.log("device: " .. d[1])
        return
      end
    end
  end
}
