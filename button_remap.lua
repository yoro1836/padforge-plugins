-- Common Xbox 360 button codes
local BTN_A = 304; local BTN_B = 305; local BTN_X = 307; local BTN_Y = 308
local BTN_LB = 310; local BTN_RB = 311
local BTN_BACK = 314; local BTN_START = 315
local BTN_LS = 317; local BTN_RS = 318
local BTN_UP = 544; local BTN_DOWN = 545; local BTN_LEFT = 546; local BTN_RIGHT = 547

return {
  id = "button_remap",
  name = "Button Remap",
  version = "1.0.0",
  author = "keyforge",
  description = "Remap up to 4 button pairs (source → target)",
  settings = {
    { key = "remap_src1", label = "Remap 1 From", kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_dst1", label = "Remap 1 To",   kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_src2", label = "Remap 2 From", kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_dst2", label = "Remap 2 To",   kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_src3", label = "Remap 3 From", kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_dst3", label = "Remap 3 To",   kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_src4", label = "Remap 4 From", kind = "number", default = "0", min = 0, max = 767 },
    { key = "remap_dst4", label = "Remap 4 To",   kind = "number", default = "0", min = 0, max = 767 },
  },
  process = function(ev, cfg, pf)
    if ev.kind ~= "button" then return ev end
    for i = 1, 4 do
      local src = tonumber(cfg["remap_src" .. i]) or 0
      local dst = tonumber(cfg["remap_dst" .. i]) or 0
      if src > 0 and dst > 0 and ev.code == src then
        pf.emit(pf.EV_KEY, dst, ev.pressed and 1 or 0)
        pf.drop()
        return ev
      end
    end
    return ev
  end
}
