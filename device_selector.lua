return {
  id = "device_selector",
  name = "Device Selector",
  version = "1.0.0",
  author = "keyforge",
  description = "Auto-select input device on startup",
  settings = {},
  process = function(ev, cfg, pf)
    return ev
  end,
  init = function(cfg, pf)
    local devices = pf.scan_devices()
    if #devices == 0 then return end
    for _, d in ipairs(devices) do
      local name = d[1]:lower()
      if name:match("xbox") or name:match("pad") or name:match("gamepad")
         or name:match("dualshock") or name:match("controller") then
        pf.set_config("VID", d[2])
        pf.set_config("PID", d[3])
        pf.log("selected: " .. d[1])
        return
      end
    end
    for _, d in ipairs(devices) do
      local name = d[1]:lower()
      if not name:match("touch") and not name:match("key")
         and not name:match("power") and d[2] ~= "0x0000" then
        pf.set_config("VID", d[2])
        pf.set_config("PID", d[3])
        pf.log("fallback: " .. d[1])
        return
      end
    end
  end
}
