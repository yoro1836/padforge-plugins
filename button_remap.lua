return {
  id = "button_remap",
  name = "Button Remap",
  version = "1.0.0",
  author = "padforge",
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
        pf.log("remap " .. src .. " → " .. dst)
        pf.emit(1, dst, ev.pressed and 1 or 0)
        return { drop = true }
      end
    end
    return ev
  end
}
