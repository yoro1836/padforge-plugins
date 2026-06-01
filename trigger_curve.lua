return {
  id = "trigger_curve",
  name = "Trigger Curve",
  version = "1.0.0",
  author = "padforge",
  description = "Adjust trigger sensitivity and output range per side",
  settings = {
    { key = "trig_left_min",  label = "LT Min",  kind = "permille", default = "0",  min = 0, max = 1000 },
    { key = "trig_left_max",  label = "LT Max",  kind = "permille", default = "1000", min = 0, max = 1000 },
    { key = "trig_right_min", label = "RT Min",  kind = "permille", default = "0",  min = 0, max = 1000 },
    { key = "trig_right_max", label = "RT Max",  kind = "permille", default = "1000", min = 0, max = 1000 },
    { key = "trig_curve",     label = "Curve",   kind = "number",   default = "1",  min = 1, max = 5 },
  },
  process = function(ev, cfg, pf)
    if ev.kind ~= "trigger" then return ev end
    local mn = tonumber(cfg["trig_" .. ev.side .. "_min"]) or 0
    local mx = tonumber(cfg["trig_" .. ev.side .. "_max"]) or 1000
    local curve = tonumber(cfg.trig_curve) or 1
    local norm = ev.value / 255.0
    local curved = math.pow(norm, curve)
    ev.value = math.floor((mn + (mx - mn) * curved) / 1000.0 * 32767.0 + 0.5)
    return ev
  end
}
