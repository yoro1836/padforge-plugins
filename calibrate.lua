return {
  id = "calibrate",
  name = "Stick Calibration",
  version = "1.0.0",
  author = "padforge",
  description = "Center offset correction",
  settings = {
    { key = "calib_lx", label = "Left X offset",  kind = "number", default = "0", min = -32767, max = 32767 },
    { key = "calib_ly", label = "Left Y offset",  kind = "number", default = "0", min = -32767, max = 32767 },
    { key = "calib_rx", label = "Right X offset", kind = "number", default = "0", min = -32767, max = 32767 },
    { key = "calib_ry", label = "Right Y offset", kind = "number", default = "0", min = -32767, max = 32767 },
  },
  process = function(stick, cfg)
    local ox = tonumber(cfg["calib_" .. stick.side:sub(1,1) .. "x"]) or 0
    local oy = tonumber(cfg["calib_" .. stick.side:sub(1,1) .. "y"]) or 0
    stick.x = stick.x - ox
    stick.y = stick.y - oy
    return stick
  end
}
