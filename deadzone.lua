return {
  id = "deadzone",
  name = "Deadzone Filter",
  version = "1.1.0",
  author = "keyforge",
  description = "Circular deadzone with Linear Scaling",
  settings = {
    { key = "deadzone_left",  label = "Left (‰)",  kind = "permille", default = "91", min = 0, max = 1000 },
    { key = "deadzone_right", label = "Right (‰)", kind = "permille", default = "91", min = 0, max = 1000 },
    { key = "min_output",     label = "Min Output (‰)", kind = "permille", default = "50", min = 0, max = 1000 },
  },
  process = function(ev, cfg, pf)
    if ev.kind ~= "stick" then return ev end

    local dz_setting = tonumber(cfg["deadzone_" .. ev.side]) or 0
    local rate = dz_setting / 1000
    local thr = 32767 * rate

    local min_setting = tonumber(cfg["min_output"]) or 0
    local min_rate = min_setting / 1000
    local min_out = 32767 * min_rate

    local axis_x = (ev.side == "left") and 0 or 3
    local axis_y = (ev.side == "left") and 1 or 4

    local dist = math.sqrt(ev.x * ev.x + ev.y * ev.y)

    if dist <= thr or dist == 0 or thr >= 32767 then
      pf.drop()
      pf.emit(pf.EV_ABS, axis_x, 0)
      pf.emit(pf.EV_ABS, axis_y, 0)
      return {}
    else
      local factor = (dist - thr) / (32767 - thr)
      
      local scaled_val = min_out + (32767 - min_out) * factor

      local scaled_x = math.floor((ev.x / dist) * scaled_val)
      local scaled_y = math.floor((ev.y / dist) * scaled_val)

      scaled_x = math.max(-32767, math.min(32767, scaled_x))
      scaled_y = math.max(-32767, math.min(32767, scaled_y))

      pf.drop()
      pf.emit(pf.EV_ABS, axis_x, scaled_x)
      pf.emit(pf.EV_ABS, axis_y, scaled_y)
      return {}
    end
  end
}
